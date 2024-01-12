#ifndef _PERI_MOD_H
#define _PERI_MOD_H

#include <stdio.h>
#include "cpu.h" // target_ulong

// part 1, from baseline pm
extern int pm_ena; // always 1

extern int pm_rand_i;
#define PM_RAND_MIN_SIZE 1
#define PM_RAND_ARR_SIZE 2048
// sizeof(target_ulong) == 4
extern int pm_rand_sz;
extern unsigned char *pm_rand;

// delimits input for fuzzer wrapper and pm buffer
#define SEGDELIM "\xf3\xc7"

#ifndef __OPEN_MULTI_STATUS__
#define __OPEN_MULTI_STATUS__
#endif


target_ulong doneWork(target_ulong);

// part 2, register categorization and prerequisite identification, and model per type
/*
 * hierarchy
 * TODO Can we reuse/backport MCU QEMU's data strcuture?
 * pm_PeripheralList: head ptr for linklist of pm_Peripheral
 * pm_Peripheral
 * pm_MMIORegister + pm_Event
 * Note: pm_Event is treated as level 3.5, as they are indicated/controlled by reg_bit
 */

/*
 * TODO for the sake of performance 
 * I use hardcoded array size/addr range in
 * PM_MAX_EVT_NUM, PM_MAX_REG_NUM, PM_PERI_ADDR_RANGE
 * In the future, size can be loaded from model learned to achieve best perf and space
 */

// Data structure for Level 4
#define PM_MAX_CR_VAL_BYTE 256
#define PM_MAX_SATISFY_NUM 32 //16 doubled because of USB firmware
#define PM_MAX_BIT_COMB_SZ 7 // assume at most 3 SR
#define PM_SET_BITS 10 // assume set at most 2=3-1 bits: set/clear, bitx, bity
// per srr_site
typedef struct {
    // srr_site is currently defined by bbl_s
    char CR_val[PM_MAX_CR_VAL_BYTE];
    target_ulong bbl_e;
    int sr_num;
    int set_bits;
    int satisfy[PM_MAX_SATISFY_NUM][PM_MAX_BIT_COMB_SZ][PM_SET_BITS];
    int satisfy_num;
    int other[PM_MAX_SATISFY_NUM][PM_MAX_BIT_COMB_SZ][PM_SET_BITS];
    int other_num;
	int is_result_hang;

    // for CR_SR read handled in SR way
    int r_idx;

    // for evt_sched's internal usage
    int cur_satisfy; // needed only by round robin evt_sched
    int cur_sr;
    // for evt_sched's internal usage
    int cur_other; // needed only by round robin evt_sched
    int cur_sr2;
	int num_read;
} pm_Event;


// Data structure for Level 3
typedef enum {
    UC = 0,
    CR,
    SR,
    DR,
    CR_SR,
} pm_reg_type_t;

char *pm_rt_str(pm_reg_type_t);

typedef enum {
    REG_NEVER = 0, // currently unused
    REG_R,
    REG_W,
} pm_reg_pa_t;


#ifdef __OPEN_MULTI_STATUS__
#define __WITHOUT_SOURCE__
#define __USING_OTHER_STATUS__
#define __OPEN_CR_SCHEDULE__

#ifdef __USING_OTHER_STATUS__
//#define __OPEN_STABLE_MODE__
#endif

//#define  __OPEN_CONSTRAINT_MODE1__
#define  __OPEN_CONSTRAINT_MODE2__
//#define  __OPEN_CONSTRAINT_MODE3__
#define  __OPEN_CONSTRAINT_MODE4__
//#define __OPEN_INT_RANDOM__
#ifdef __WITHOUT_SOURCE__
extern target_ulong startForkserver(CPUArchState *env,target_ulong enableTicks);
#endif
#define __CR_SR_CHANGE__
//#define EFF_FACTOR1 0x3c1fu	// a random prime
#define EFF_FACTOR1 0x7u	// a random prime
#define EFF_FACTOR2 0x3u // the most num of cr value written by firmware are 7
#define NUM_CTRL_VAL 0x10
#define NUM_CHANGE_STATUS 253
extern bool __attribute__((unused)) is_fac1_sat_func(void);
extern volatile bool using_other_status;

// Effective control values
extern volatile target_ulong cur_pc;  //record the current pc value
typedef struct {
	target_ulong val;	// control value
	target_ulong bbl_s; // the basic block start
	target_ulong bbl_e; // the basic block end
	uint32_t time_rd;   // read time
} eff_vals;  
extern volatile unsigned int bbl_exec_times;
extern volatile unsigned int last_bbl_exec;
extern volatile uint32_t last_CR_SR_peri_addr;
extern volatile uint32_t last_CR_SR_bbl_s;
extern volatile uint32_t last_CR_SR_bbl_e;
extern volatile int last_CR_SR_bbl_cnt;
extern volatile int cur_excp_num;
#endif

typedef struct {
    pm_reg_type_t type;
    target_ulong val; 

    // record value of cr when SR_r happens
    target_ulong cr_val;

#ifdef __OPEN_MULTI_STATUS__
	target_ulong addr;  // addr where consume the value
	eff_vals evals[NUM_CTRL_VAL]; // effective status/control val
	int num_eval;	// num of the cr_val
	pm_reg_pa_t last_op;	// last op type
	int max_id;  // eff_val id which has the most use times
	uint32_t max_times;  // max use times
	int last_cr_id;	// last used explore id
	bool result_hang_in_while;
	int hang_r_idx_in_bbl; 
#endif
    // category of CR_SR/SR is locked
    int sr_locked;
    int dr_locked;
	
    // used by CR/CR_SR/maybe SR in the future
    // there may be multiple read on CR_SR in same bbl, some handled in CR way. 
    // at most ONE in SR way (its 0-started read idx is recorded here)
    int r_idx_in_bbl;
    int last_r_bbl_cnt;

    // has ever/never(0/1) been read/write
    int read;
    int write;

} pm_MMIORegister;
extern bool run_from_afl;
extern uint32_t main_eaddr;
extern int len_seeds;
extern int len_round;
extern int hang_mode;

// Data structure for Level 2
// TODO 1kb or 4kb, which is better?
#define PM_PERI_ADDR_RANGE 1024
#define PM_MAX_REG_NUM (PM_PERI_ADDR_RANGE >> 2)
#define PM_MAX_EVT_NUM 512

// 0'ed in create_peri
typedef struct pm_Peripheral{
    target_ulong base_addr;

    // regs
    pm_MMIORegister regs[PM_MAX_REG_NUM];
    pm_MMIORegister regs_back[PM_MAX_REG_NUM];
    int max_reg_idx;
    int DR_bytes_num; // num of bytes used in DR, to avoid wasting AFL input
    unsigned reg_size; // bytes in each reg

    // events
    // for each event, key = (CR_val, bbl_e), val = (bit combinations)
    pm_Event events[PM_MAX_EVT_NUM];
    unsigned int evt_num; // i.e. srr_site num
	
	bool hang_in_while_flag;
    struct pm_Peripheral *next; 
} pm_Peripheral;


// Data structure & operations for Level 1
extern pm_Peripheral * volatile pm_PeripheralList;
pm_Peripheral *create_peri(target_ulong);
pm_Peripheral *get_peri(target_ulong);


// dump/load 
int pm_dump_model(pm_Peripheral *);
int pm_load_model(pm_Peripheral **);
pm_Peripheral *pm_reload_model(void);

// handles SR read, the most trick register
target_ulong pm_SR_read (pm_Event *, pm_MMIORegister *);

// multi-status mode function
#ifdef __OPEN_MULTI_STATUS__
target_ulong pm_CR_read (pm_MMIORegister *);
#endif  // __OPEN_MULTI_STATUS__

//#define __OPEN_ILLEGAL_RECORD__
#ifdef __OPEN_ILLEGAL_RECORD__ 
#define RECORD_ILLEGAL_OPERATION(str, addr) \
	FILE *rfp = fopen("/tmp/block_illegal_op.log", "a+");   \
    fprintf(rfp, "[%x, %x]: illegal %s at %#x\n", cur_bbl_s, cur_bbl_e, str, addr);  \
    fclose(rfp);
#else
#define RECORD_ILLEGAL_OPERATION(str, addr) {}
#endif  // __OPEN_ILLEGAL_RECORD__

extern int pm_me_ena; // 1: model extraction process, 0: fuzzing process


// part 3, stages, plus data structures and methods for each stage
typedef enum {
    INVALID = 0, // atoi(optarg) rets 0 when invalid in vl.c
    SR_R_ID,
    SR_R_EXPLORE,
    FUZZING,
} pm_stage_t;

// All stages
extern pm_stage_t pm_stage;
extern const char *model_if;
extern const char *model_of;
// # of bbl has been executed
// for stage 1, the number is dumped into JSON and includes bbl where SR_r happens
extern volatile unsigned int bbl_cnt; // # of BBL that has finsihed exec
extern uint32_t cur_bbl_s, cur_bbl_e;

// SR_R_ID stage
// terminate when observe real SR_r
#define MAX_SR_NUM 12
extern volatile int cur_bbl_SR_r_num;
extern volatile int stage_term_reg_idx[MAX_SR_NUM]; // XXX by stage 1 & 3
#ifdef __OPEN_MULTI_STATUS__
extern volatile target_ulong stage_term_peri_ba[MAX_SR_NUM]; // XXX by stage 1 & 3
extern volatile target_ulong stage_term_peri_ba_exp[MAX_SR_NUM] ;
extern volatile int stage_term_reg_idx_exp[MAX_SR_NUM];
extern volatile int cur_bbl_SR_r_num_exp;
#else
extern volatile target_ulong stage_term_peri_ba; // XXX by stage 1 & 3
#endif
extern char *sr_func;
pm_Event *pm_SR_find_model(uint32_t, pm_Peripheral *, pm_MMIORegister *);
extern volatile int consec_same_reg_r;
#define CONSEC_NON_SR_R_THRESHOLD 50
extern volatile int SR_cat_by_fixup;

// SR_R_EXPLORE
extern const char *SR_r_file;
extern volatile unsigned int target_bbl_cnt;
extern uint32_t *sr_func_ret_addr;
int is_sr_func_ret_addr(uint32_t);
extern FILE *trace_f;
extern FILE *reg_acc_f;
extern volatile int expl_started;
#define SR_R_THRESH_HOLD 4 // usart isr has at most 4 unpexted sr_r
extern uint32_t srr_site;
#define SR_R_WORKER_BBL_CNT_CAP 20000 // 20k

// SR_R_ID & SR_R_EXPLORE
void stage_termination(pm_stage_t);
// replay until this bbl_cnt in me of fuzzing
// cnt doesn't include the BBL in which AUP happens
extern unsigned int replay_bbl_cnt;
extern volatile unsigned int bbl_cnt_last_me;
#define ME_TERM_THRESHOLD 30000 // 30k
extern int CR_SR_r_idx_in_bbl; // 1-started index, 0 if not used

// FUZZING
extern const char *aflFile;
extern const char *DMAFile; // this option is only for testing
#define PM_UNCAT_REG 0x40
#define PM_UNMOD_SRRS 0x41
#define PM_ME_EXIT 0x50
extern const char *me_bin;
extern const char *me_config;
extern int run_num;
extern int aup_reason;
extern int afl_startfs_invoked;
#ifdef __OPEN_MULTI_STATUS__
extern volatile bool has_seed_consume;
extern volatile bool has_crsr_read;
#define MAX_CONT_DMA_CNT 10000
#endif

#endif /* _PERI_MOD_H */

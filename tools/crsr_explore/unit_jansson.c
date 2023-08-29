#include <stdio.h>
#include <string.h>
#include <jansson.h>
#include <stdlib.h>
#define FILE_PATH "./peri.json"
#define NUM_MAX_EVAL 0x5
#define NUM_REG 0x2
#define target_ulong unsigned

//gcc unit_jansson.c `pkg-config --libs --cflags jansson`
typedef struct {
    target_ulong val;   // control value
    target_ulong pc;    // pc which need the control value <dynamic>
    target_ulong addr;  // addr where consume the value
    int time_use; // how many times this value is used ?
    //XXX other variables
} eff_vals;

typedef struct Regs {
	char name[20];
	eff_vals evals[NUM_MAX_EVAL];
	int num_eval;
}Regs;

/*
typedef struct Regs1 {
	char *name;
	eff_vals evals[NUM_MAX_EVAL];
	int num_eval;
}Regs1;
*/

Regs regs[NUM_REG] = {
	
	{
		.name = "device01",
		.evals = {
			{
				.val = 0x11111111,
				.pc  = 0x22222222,
				.addr = 0x33333333,
				.time_use = 2
			}, {
				.val = 0x44444444,
				.pc  = 0x55555555,
				.addr = 0x66666666,
				.time_use = 3
			}
		},
		.num_eval = 2
	},{
		.name = "device02",
		.evals = {
			{
				.val = 0x77777777,
				.pc  = 0x88888888,
				//.addr = 0x99999999,
				//.time_use = 2
			}, {
				.val = 0xaaaaaaaa,
				.pc  = 0xbbbbbbbb,
				.addr = 0xcccccccc,
				.time_use = 3
			}
		},
		.num_eval = 2
	}
};

/*
 * Create json file
 */
int json_create() {

	json_t *jregs = json_array();
	for(int i = 0; i < NUM_REG; i++) {
		json_t *jreg = json_object(); 
		json_t *eff_vals = json_array();
		for(int j = 0; j < regs[i].num_eval; j++) {
			char val[16], pc[16], addr[16];
			sprintf(val, "0x%x", regs[i].evals[j].val);
			sprintf(pc, "0x%x", regs[i].evals[j].pc);
			sprintf(addr, "0x%x", regs[i].evals[j].addr);
			json_t *eff_vali = json_pack("{s:s, s:s, s:s, s:i}",
							"val", val,
							"pc", pc,
							"addr", addr,
							"time_use", regs[i].evals[j].time_use
							);
			json_array_append_new(eff_vals, eff_vali);
		}
		json_object_set_new(jreg, "name", json_string(regs[i].name));
		json_object_set_new(jreg, "evals", eff_vals);
		json_object_set_new(jreg, "num_eval", json_integer(regs[i].num_eval));
		json_array_append_new(jregs, jreg);
	}
	json_t *jreg1= json_object(); 
	json_t *eff_val1 = json_array();
	json_object_set_new(jreg1, "name", json_string("chunlin003"));
	json_object_set_new(jreg1, "evals", eff_val1);
	json_array_append_new(jregs, jreg1);
	json_dump_file(jregs, FILE_PATH, JSON_INDENT(4));
	if(jregs)
		json_delete(jregs);
	return 0;
}

/*
 * read json file
 */
int json_read() {

	Regs regs1[NUM_REG];
	json_error_t error;
	json_t *jregs = NULL;
	jregs = json_load_file(FILE_PATH, 0, &error);
	if(!json_is_array(jregs)) {
		printf("error: %s\n", error.text);
	}
	for(int i = 0; i < NUM_REG; i++) {
		json_t *jreg = json_array_get(jregs, i);
		json_t *evals = json_array();
		char *name1;
		int num_eval;
		json_unpack_ex(jreg, &error, 0, "{s:s, s:o, s:i}", "name", &name1, 
						"evals", &evals, "num_eval", &num_eval);
		strncpy(regs1[i].name, name1, 20);
	//char *str = json_dumps(evals, JSON_INDENT(4));
	//printf("%s\n",str);
		//printf("num_eval = %d\n", num_eval);
		for(int j = 0; j < num_eval; j++) {
			json_t *eval = json_array_get(evals, j);
			char *val, *pc, *addr;
			json_unpack_ex(eval, &error, 0, "{s:s, s:s, s:s, s:i}",
							"val", &val, "pc", &pc, "addr", &addr,
							"time_use", &regs1[i].evals[j].time_use);
			regs1[i].evals[j].val = strtol(val, NULL, 16);
			regs1[i].evals[j].pc = strtol(pc, NULL, 16);
			regs1[i].evals[j].addr = strtol(addr, NULL, 16);
		}
	}

	for(int i = 0; i < NUM_REG; i++) {
		printf("-------\n"  
				"regs[%d], name = %s\n", i, regs1[i].name);		
		for(int j = 0; j < regs[i].num_eval; j++) {
			printf(	"---------\n"
					"val = %08x\n"
					"pc = %08x\n"
					"addr = %08x\n"
					"time_use = %d\n",
					regs1[i].evals[j].val,
					regs1[i].evals[j].pc,
					regs1[i].evals[j].addr,
					regs1[i].evals[j].time_use
					);
		}
		printf("num_eval = %d\n", regs1[i].num_eval);
	
	}

}

int main() {

	//json_create();
	json_read();
	return 0;
}

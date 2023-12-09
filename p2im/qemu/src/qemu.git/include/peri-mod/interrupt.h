#ifndef _INTERRUPT_H
#define _INTERRUPT_H

typedef struct {
    // exception number under NVIC instead of GIC
    // NVIC: exception no = int no + 16
    // GIC: exception no = int no + 32
    int int_num;
    int enabled;
	int freq; // frequency
	int result_hang; // if the current interrupt will cause hang;
} pm_Int;


#define PM_MAX_INT_EN_NUM 64
typedef struct {
    // CortexMNVICState */nvic_state *
    void *s;

    pm_Int arr[PM_MAX_INT_EN_NUM];
    int arr_size;

    // arr idx dictating next interrupt to fire
    int cur_int;
} pm_Interrupt;

extern pm_Interrupt *pm_interrupt;

void pm_enable_interrupt(int);
void pm_disable_interrupt(int);
void pm_fire_interrupt(void);

// pm_stage ME
#define INT_ROUND 2
extern volatile int int_round;
extern volatile int is_int_triggered; // if interrupt is triggered

// pm_stage FUZZING
#define FUZZING_INT_FREQ 100

#endif /* _INTERRUPT_H */

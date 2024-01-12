#ifndef _DMA_H
#define _DMA_H

#include <stdio.h>
#include "cpu.h" // target_ulong
#include "../include/hw/arm/cortexm-mcu.h"

//STM32F103RB
/*
#define RAM_START 0x20000000
#define RAM_END 0x20005400
#define RAM_START_ALT 0x20000000
#define RAM_END_ALT 0x20005400

#define FLASH_START 0x08000000
#define FLASH_END 0x0801FFFF
#define FLASH_START_ALT 0x08000000
#define FLASH_END_ALT 0x0801FFFF

#define PERI_START 0x40000000
#define PERI_END 0x60000000
#define PERI_START_ALT 0x40000000
#define PERI_END_ALT 0x60000000
*/

 //SAM3X Arduino DUE
 //this constants are deprecated we do not need them
#define RAM_START 0x20000000
#define RAM_END 0x200FFFFF
#define RAM_START_ALT 0x20000000
#define RAM_END_ALT 0x200FFFFF

#define FLASH_START 0x08000000
#define FLASH_END 0x0801FFFF
#define FLASH_START_ALT 0x08000000
#define FLASH_END_ALT 0x0801FFFF

#define PERI_START 0x40000000
#define PERI_END 0x400FFFFF
#define PERI_START_ALT 0x40000000
#define PERI_END_ALT 0x400FFFFF



#define MAX_POINTERS 64
#define MAX_DMA_DESC MAX_POINTERS/2
// beat address should be at least 16kb stepper firmware uses 4kb
#define MAX_DMA_BEAT_ADDRESS 2048 
//#define DMA_SPAN_BUFFER 64
#define DMA_SPAN_BUFFER 4


#define MAX_DMA_READ 2048

#define NONUM 255

#define NUMCANARIES 20

// enum DMA transfer direction
typedef enum {
    MEMTOPERI = 0,
    PERITOMEM,
    NODIR
}pm_dma_transfer_dir_t;

// enum type of access to descriptor pointers (dereference)
typedef enum {
    READ = 0,
    WRITE,
    READWRITE,
    NOACCESS
}pm_dma_access_type_t;


typedef struct {
    target_ulong address;
    pm_dma_access_type_t access;
    int exc_num_dma;
}pm_dma_buffer_beat;

// enum for DMA pointer type
typedef enum {
    TRAM = 0,
    TFLASH,
    TPERIPHERAL,
    TUNKNOWN
} pm_pointer_type_t;


typedef struct {
   target_ulong address;
   int size;
}pm_dma_canary;

typedef struct 
{
    int id; //unique id for each DMA pointer identified
    int id_ctp; // id of DMA pointer counterpart
    target_ulong base; //base of peripheral
    target_ulong register_addr; //address of CR register that was written
    target_ulong value; // value to be written on CR
    target_ulong ordinal; // ordinal number at wich the write operation happened
    pm_pointer_type_t type; // type of pointer according to major memory areas Peripheral, RAM, Flash

}pm_DMA_pointers;


typedef struct {  
    int id_pointer_mem; //first
    int id_pointer_peri; //second
    
    pm_DMA_pointers pointer_mem;
    pm_DMA_pointers pointer_peri;

    int beat_size;   //number of "beats" to be transfered  a beat could be 8, 16, 32 bit 
    int number_beats;   //beat_size x number_beats= transfer size in bytes       
    pm_dma_access_type_t  t_access_mem; 
    pm_dma_access_type_t  t_access_peri;
    pm_dma_transfer_dir_t direction;
    int exc_num_dma; //exception number IRQ
    int version; //1: single pointer (NRF52832) , 2: Double pointer (F103, F429)
} pm_DMA_desc;


//Global variable
extern CortexMState *cs_g;
extern uint32_t cur_bbl_s, cur_bbl_e;
extern int number_dma_buff_addreses;
extern int number_dma_pointers;
extern int number_dma_descriptors;
extern pm_DMA_desc dma_descriptors[MAX_DMA_DESC];
extern pm_DMA_pointers dma_pointers[MAX_POINTERS];
extern pm_dma_buffer_beat dma_buffer_addresses[MAX_DMA_BEAT_ADDRESS];
extern int num_dma_read;
extern pm_dma_canary canaries[NUMCANARIES];
extern int number_canaries;
extern int exception_num_dma;
extern bool exception_active_dma; 



// Function prototypes
//Returns the corresponding pointer type according to memory range
static pm_pointer_type_t get_pointer_type(target_ulong value);
static pm_pointer_type_t get_pointer_type(target_ulong value){
    if  ((value >= cs_g->sram_base && value < (cs_g->sram_base+cs_g->sram_size_kb*1024)) 
    || (value >=cs_g->sram_base2  && value < (cs_g->sram_base2+cs_g->sram_size_kb2*1024))
    || (value >=cs_g->sram_base3  && value < (cs_g->sram_base3+cs_g->sram_size_kb3*1024)))            
    {
        return TRAM;
    }
    if  ((value >= cs_g->flash_base && value < cs_g->flash_size_kb*1024))            
    {
        return TFLASH;
    }
    if (value >= 0x40000000  && value < 0x60000000)            
    {
        return TPERIPHERAL;
    }
    return TUNKNOWN;
}

static bool __attribute__((unused)) valid_descriptor_pointers(target_ulong p1, target_ulong p2);
static bool __attribute__((unused)) valid_descriptor_pointers(target_ulong p1, target_ulong p2 )
{
    pm_pointer_type_t pt1, pt2;

    pt1= get_pointer_type(p1);
    pt2= get_pointer_type(p2);
    
    if( pt1==TUNKNOWN || pt2==TUNKNOWN) return false;

    if( pt1==TFLASH && pt2==TFLASH) return false;
    if( pt1==TFLASH && pt2==TRAM) return false; //this should be true but generates too many false positives
    if( pt1==TFLASH && pt2==TPERIPHERAL) return false; //this should be true but generates too many false positives

    if( pt1==TRAM && pt2==TFLASH) return false; //this should be true but generates too many false positives
    if( pt1==TRAM && pt2==TRAM) return true;  
    if( pt1==TRAM && pt2==TPERIPHERAL) return true;

    if( pt1==TPERIPHERAL && pt2==TFLASH) return false;
    if( pt1==TPERIPHERAL && pt2==TRAM) return true;
    if( pt1==TPERIPHERAL && pt2==TPERIPHERAL) return false; //this should be true but we are not able to emulate this type of DMA transfer
	return false;   
}

static int __attribute__((unused)) cmp_address_DMA(const void *a, const void *b);
static int __attribute__((unused)) cmp_address_DMA(const void *a, const void *b)
{
	pm_dma_buffer_beat *aa; 
 	pm_dma_buffer_beat *bb;
 	aa = (pm_dma_buffer_beat *)a;
 	bb = (pm_dma_buffer_beat *)b;
    return(aa->address - bb->address);
}



static void __attribute__((unused)) delete_dma_descriptor(int descriptor_id);
static void __attribute__((unused)) delete_dma_descriptor(int descriptor_id)
{
   int i;
   for(i = descriptor_id; i < (number_dma_descriptors - 1); i++)
   {
       dma_descriptors[i] = dma_descriptors[i + 1];
   }
   number_dma_descriptors--;
}


#endif //_DMA_H

/*
 * Author: Chunlin Wang
 * Date: 2020-10-05
 * E-mail: chunlin_wang01@163.com
 * Description: To improve the accurate of register identification
 *         		We introduce database match mode. Dice will turn to
 *          	pattern mode when it can not search the effective values
 *          	within special thresh hold.
 */
 
#ifndef __DATABASE_H__
#define __DATABASE_H__

#include <stdio.h>
//#include "cpu.h"
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <mysql/mysql.h>

//MYSQL mysql; //global mysql handler
// Load register info from database
#define MAX_REG_NUM 512 //TODO need to adjust later
#define MAX_REG_VALUE_NUM 64 //the num of effective register value 
#define ERROR_RESET_VAL 0x11111111 //error value
typedef struct db_Register {

    uint32_t addr; //reg addr
    uint32_t rval;  //reset val of reg
    int type; //reg type
    uint32_t eff_val[MAX_REG_VALUE_NUM]; //effective vlaue
    uint32_t nval;  //num of effective values
    int is_special; //is a special reg, such watchdog reset value
	struct db_Register *next;
    
} db_Register;

/*
 * Some global/extern variable
 */
extern MYSQL mysql;
extern db_Register *reg_list;

/*
 * Init mysql handler and connect to it.
 * return 0 if success, or return -1
 */
int init_mysql(MYSQL *mysql);

/*
 * Close the mysql database 
 */
void close_mysql(MYSQL *mysql);

/*
 * Exec sql terminal
 * @mysql: mysql handler
 * @query: cmd string need to be execed.
 * return 0 if success, or return -1.
 */
int exec_mysql_terminal(MYSQL *mysql, char *query); 

/*
 * Get reset value from database according to addr
 * return reset value if success, or return ERROR_RESET_VAL
 */
uint32_t get_reset_value(MYSQL *mysql, char *tb, uint32_t addr); 

/*
 * Get db_register structure from database according to addr
 * return 0 when success, or -1
 */
int get_db_register1(MYSQL *mysql, db_Register *db_reg, 
				char *tb, uint32_t addr);

/*
 * Obtain basic info from XXX_info 
 * @bdname: board name 
 * @addr: the address of register
 * return db_Register* if success, or return NULL
 */
db_Register *get_db_register(MYSQL *mysql, char *bdname, uint32_t addr);

/*
 * Reading effective from XXX_val according to board name and addr
 *
 * return 0 if success, or return -1.
 */
int get_eff_val(MYSQL *mysql, db_Register *db_reg,
                char *bdname, uint32_t addr);

/*
 * Init db_Register list according to database
 * return 0 if success, or return -1;
 */
int init_reg_list(MYSQL *mysql, char *bdname);

/*
 * Print register info from reg_list
 */
void print_reg_list();


#endif //__DATABASE_H__

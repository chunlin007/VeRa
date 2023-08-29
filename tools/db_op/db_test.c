#ifndef _REG_DB_H
#define _REG_DB_H

#include <stdio.h>
#include <string.h>
#include <mysql/mysql.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

/*
 * Complier sentence bellow:
 * gcc mysqltest.c -o mysqltest `pkg-config --libs --cflags mysqlclient`
 */

//Borrow from pero-mod.h
// Data structure for Level 3
typedef enum {
    UC = 0,
    CR,  //CR or IE
    SR,
    DR,
    CR_SR,
} pm_reg_type_t;

/*
 * To save reg info read from mysql db
 */
#define MAX_REG_VALUE_NUM 64 //the num of effective register value
#define MAX_REG_NUM 256 //TODO need to adjust later
typedef struct db_Register {

    uint32_t addr; //reg addr
    pm_reg_type_t type; //reg type
	uint32_t rval; //reset val of reg
    uint32_t eff_val[MAX_REG_VALUE_NUM]; //effective vlaue
	int nval; //num of effective values
    bool is_special; //is a special reg, such watchdog reset value
	struct db_Register *next;

} db_Register;

db_Register db_regs[MAX_REG_NUM];
db_Register *reg_list = NULL;

/*
 * Init reg_list
 * return 0 if success or return -1
 */
int init_head_node() {

	reg_list = (db_Register *)malloc(sizeof(db_Register));
	if(NULL == reg_list) {
		return -1;
	}
	reg_list->next = NULL;
	return 0;
}

/*
 * exec sql terminal
 */
int exec_mysql_terminal(MYSQL *mysql, char *query) {
	
	/* return 0 if check successfully */
	int flag = mysql_real_query(mysql, query, (unsigned int)strlen(query));
	if(flag) {
		return -1;
	} 
	return 0;
}

/*
 * Add item into table
 */
int insert_into_table(MYSQL *mysql, char *query) {

	if(exec_mysql_terminal(mysql, query) < 0) {
		return -1;
	} else {
		printf("insert into table success!\n");
	}
	return 0;
}

/*
 * insert into tables according to table name and values(val, id)
 * @tb: table name
 * @val: value will insert into table
 * return 0 if insert success, or return -1
 */
int insert_into_table2(MYSQL *mysql, char *tb, uint32_t addr, uint32_t val) {

	char query[100];
	sprintf(query, "insert into %s (addr, val) values(%d, %d);", tb, addr, val);
	if(exec_mysql_terminal(mysql, query) < 0) {
		return -1;
	} else {
		printf("insert into table success!\n");
	}
	return 0;
}

/*
 * insert value into stm32f303re_info
 */
int insert_into_table3(MYSQL *mysql, char *tb, 
				uint32_t base, uint32_t arr[][3]) {

	char query[100];
	for(int i = 0; i < 0x3ff; i++) {
		
		if(arr[i][2] == 0xf) {
			break;
		}
		memset(query, 0, 100 * sizeof(char));
		sprintf(query, "insert into %s (addr, rval, type, is_special) \
						values(%u, %u, %d, %d);", \
						tb, base + 0x4 * i, arr[i][0], arr[i][1], arr[i][2]);
		if(exec_mysql_terminal(mysql, query) < 0) {
			return -1;
		} 
	}
	return 0;
}

/*
 * insert value into table-stm32f303re_info_val according id and val array
 * @base: peripheral base address
 */
int insert_into_table4(MYSQL *mysql, char *tb, 
				uint32_t base, uint32_t arr[][32]) {

	char query[100];
	for(int i = 0; i < 0x3ff; i++) {

		if(arr[i][0] == 0xffffffff && arr[i + 1][0] == 0xffffffff) {
			break;
		}
		for(int j = 0; j < 32; j++) { 

			if(arr[i][j] == 0) {
				break;
			}
			memset(query, 0, 100 * sizeof(char));
			sprintf(query, "insert into %s (addr, val) values(%u, %u);",
					tb, base + i * 0x4, arr[i][j]);
			if(exec_mysql_terminal(mysql, query) < 0) {
				return -1;
			}
		}
	}
	return 0;
}

/*
 * Delete item from table
 */
int delete_from_table(MYSQL *mysql, char *query) {

	if(exec_mysql_terminal(mysql, query) < 0) {
		return -1;
	} else {
		printf("delete data from table success!\n");
	}
	return 0;
}


/*
 * Search item and print content in table
 */
int search_from_table(MYSQL *mysql, char *query) {

	if(exec_mysql_terminal(mysql, query) < 0) {
		return -1;
	}
	// read all content from database and store into client
	MYSQL_RES *res = mysql_store_result(mysql);
	if(NULL == res) {
		return -1;
	}
	// fetch content line by line
	MYSQL_ROW row;
	while(row = mysql_fetch_row(res)) { 
		// print value in every line 
		for(int l = 0; l < mysql_num_fields(res); l++) {
			
			printf("%-s\t", row[l]);
		}
		printf("\n");
	}
	return 0;
}

/*
 * Get mysql resources from database
 */
MYSQL_RES *get_reg_resource(MYSQL *mysql, char *query) {

	if(exec_mysql_terminal(mysql, query) < 0) {
		//printf("exec_mysql_terminal error!\n");
		return NULL;
	}
	// read all content from database and store into client
	MYSQL_RES *res = mysql_store_result(mysql);
	if(NULL == res) {
		//printf("mysql_store_result error!\n");
		return NULL;
	}
	return res;
}

/*
 * Init db_regs according to db_register database
 * @mysql: handler used to connect mysql database
 * return 0 if init success, or return -1.
 */
int reg_nums = 0;
int db_register_init(MYSQL *mysql) {

	char *query = "select * from stm32f303re_info";
	MYSQL_RES *res1, *res2;
	if(NULL == (res1 = get_reg_resource(mysql, query))) {
		
		return -1;
	}
	// fetch content line by line
	MYSQL_ROW row1, row2;
	uint32_t addr_tmp;
	while(row1 = mysql_fetch_row(res1)) { 

		addr_tmp = strtoul(row1[1], NULL, 10);
		db_regs[reg_nums].addr = addr_tmp;
		db_regs[reg_nums].rval = strtoul(row1[2], NULL, 10);
		db_regs[reg_nums].type = atoi(row1[3]);
		db_regs[reg_nums].is_special = atoi(row1[4]);
		int id = atoi(row1[0]);
		char query2[100];
		sprintf(query2, "select val from stm32f303re_info_val where addr = %u", addr_tmp);
		if(NULL == (res2 = get_reg_resource(mysql, query2))) {

			return -1;
		}
		printf("addr_tmp = %08x\n", addr_tmp);
		int k = 0;
		while(row2 = mysql_fetch_row(res2)) {

			db_regs[reg_nums].eff_val[k] = strtoul(row2[0], NULL, 10);
			k++;
		}
		db_regs[reg_nums].nval = k;
		reg_nums++;
	}
}


/*
 * Init db_Register list according to database
 * return 0 if success, or return -1;
 */
int init_reg_list(MYSQL *mysql, char *bdname) {

	if(0 > init_head_node()) {
	//	perror("init_head_node failed\n");
		return -1;
	}
    //read info from database
    char query[100];
    memset(query, 0, sizeof(char) * 100);
    sprintf(query, "select addr,rval,type,is_special from %s_info", bdname);
    MYSQL_RES *res1 = NULL, *res2 = NULL;
    if(NULL == (res1 = get_reg_resource(mysql, query))) {
        return -1;
    }
    MYSQL_ROW row1, row2;
    uint32_t addr_tmp;
    int k = 0;
    db_Register *db_ptr = reg_list;
    while(row1 = mysql_fetch_row(res1)) {

        db_Register *db_reg = (db_Register*)malloc(sizeof(db_Register));
        if(NULL == db_regs) {
            return -1;
        }
        addr_tmp = strtoul(row1[0], NULL, 10);
        db_reg->addr = addr_tmp;
        db_reg->rval = strtoul(row1[1], NULL, 10);
        db_reg->type = atoi(row1[2]);
        db_reg->is_special = atoi(row1[3]);
        memset(query, 0, sizeof(char) * 100);
        sprintf(query, "select val from %s_val where addr = %u", bdname, addr_tmp);
        if(NULL == (res2 = get_reg_resource(mysql, query))) {
            return -1;
        }
        k = 0;
        while(row2 = mysql_fetch_row(res2)) {
            db_reg->eff_val[k] = strtoul(row2[0], NULL, 10);
            k++;
        }
        db_reg->nval = k;
        db_ptr->next = db_reg;
        db_ptr = db_reg;
    }
}


/*
 * Get rval from table according to addr
 */
#define ERROR_RESET_VAL 0x10101010
uint32_t get_reset_value(MYSQL *mysql, char *tb, uint32_t addr) {

    char query[100];
    sprintf(query, "select * from %s where addr = %u", tb, addr);
	if(0 > exec_mysql_terminal(mysql, query)) {
		perror("exec_mysql_terminal error!\n");
		return ERROR_RESET_VAL;
	}
    MYSQL_RES *res = mysql_store_result(mysql);
    if(NULL == res) {
        perror("mysql_store_result error!\n");
        return ERROR_RESET_VAL;
    }
    MYSQL_ROW row = mysql_fetch_row(res);
	printf("id = %d, type = %d, is_special = %d\n", atoi(row[0]), atoi(row[3]), atoi(row[4]));
    return strtoul(row[1], NULL, 10);
}

/*
 * Obtain basic info from XXX_info 
 * @bdname: board name 
 * @addr: the address of register
 * return db_Register* if success, or return NULL
 */
db_Register *get_db_register(MYSQL *mysql, char *bdname, uint32_t addr) {

    //get info from XXX_info (rval, type, is_special)
    char query[100];
    memset(query, 0, sizeof(char) * 100);
    sprintf(query, "select * from %s_info where addr = %u", bdname, addr);
    if(0 > exec_mysql_terminal(mysql, query)) {
        return NULL;
    }
    MYSQL_RES *res = mysql_store_result(mysql);
    if(NULL == res) {
        return NULL;
    }
    MYSQL_ROW row = mysql_fetch_row(res);
    db_Register *db_reg = (db_Register *)malloc(sizeof(db_Register));
    if(NULL == db_reg) {
        return NULL;
    }
    db_reg->addr = addr;
    db_reg->rval = strtoul(row[1], NULL, 10);
    db_reg->type = atoi(row[2]);
    db_reg->is_special = atoi(row[2]);
    return db_reg;
}

/*
 * Reading effective from XXX_val according to board name and addr
 * @db_reg: reg need to modified
 * return 0 if success, or return -1.
 */
int get_eff_val(MYSQL *mysql, db_Register *db_reg,
                char *bdname, uint32_t addr) {

    //get info from XXX_val (values)
    char query[100];
    memset(query, 0, sizeof(char) * 100);
    sprintf(query, "select val from %s_val where addr = %u", bdname, addr);
    if(0 > exec_mysql_terminal(mysql, query)) {
        return -1;
    }
    MYSQL_RES *res = mysql_store_result(mysql);
    if(NULL == res) {
        return -1;
    }
    MYSQL_ROW row;
    int k = 0;
    while(row = mysql_fetch_row(res)) {
        db_reg->eff_val[k] = atoi(row[0]);
        k++;
    }
    db_reg->nval = k;
    return 0;
}



/*
 * Test db_regs-index
 */
void test_db_register() {

	for(int i = 0; i < reg_nums; i++) {
		
		printf("db_regs[%d].addr = %08x\n", i, db_regs[i].addr);
		printf("db_regs[%d].rval = %08x\n", i, db_regs[i].rval);
		printf("db_regs[%d].type = %d\n", i, db_regs[i].type);
		printf("db_regs[%d].is_special = %d\n", i, db_regs[i].is_special);
		for(int j = 0; j < db_regs[i].nval; j++) {

			if(0 == j)
				printf("db_regs[%d].eff_val[%d]: ",i, j);
			printf("%08x\t", db_regs[i].eff_val[j]);
		}
		printf("\n------------------\n");
	}
}

/*
 * Print reg_list info
 */
void print_reg_list() {

	db_Register *db_ptr = reg_list;
	while(db_ptr) {
		
		printf("addr = %08x\t", db_ptr->addr);
		printf("rval = %08x\t", db_ptr->rval);
		printf("type = %d\t", db_ptr->type);
		printf("is_special = %d\n", db_ptr->is_special);
		printf("effective values num = %d\n", db_ptr->nval);
		for(int j = 0; j < db_ptr->nval; j++) {

			if(0 != j && 0 == j % 4)
				printf("\n");
			printf("%08x\t", db_ptr->eff_val[j]);
		}
		printf("\n------------------\n");
		db_ptr = db_ptr->next;
	}
}

/*
 * Reset mysql
 */
int reset_db_register(MYSQL *mysql) {/*{{{*/

	char *query = "delete from stm32f303re_info_val where id > 0";
	if(0 > exec_mysql_terminal(mysql, query)) {
		printf("delete from stm32f303re_info_val failed\n");
		return -1;
	}
	query = "alter table stm32f303re_info_val auto_increment = 1";
	if(0 > exec_mysql_terminal(mysql, query)) {
		printf("reset auto_increment in stm32f303re_info_val failed\n");
		return -1;
	}
	query = "delete from stm32f303re_info where id > 0";
	if(0 > exec_mysql_terminal(mysql, query)) {
		printf("delete from stm32f303re_info failed\n");
		return -1;
	}
	query = "alter table stm32f303re_info auto_increment = 1";
	if(0 > exec_mysql_terminal(mysql, query)) {
		printf("reset auto_increment in stm32f303re_info failed\n");
		return -1;
	}
}/*}}}*/


int main() 
{

	//========== Init & Connect =============
	MYSQL mysql;
	mysql_init(&mysql);
	MYSQL *ret = mysql_real_connect(&mysql, "localhost", "user0", \
					"User0@1357", "db_register", 3306, NULL, 0);
	if(NULL == ret) {
		perror("Fail to connect to mysql\n\n");
		return -1;
	} 
	/*
	 * Test for init_reg_list
	 */
	if(0 > init_reg_list(&mysql, "stm32f303re")) {
		perror("init_reg_list failed\n");
		return -1;
	}
	print_reg_list();	
	/*
	 * Test get_reset_val  
	 */
	/*
	uint32_t reset_val = get_reset_value(&mysql, "stm32f303re_info", 0x48000000);
	if(ERROR_RESET_VAL == reset_val) {
		perror("get_reset_value error!\n");
		return -1;
	}
	printf("reset_val = %08x\n",reset_val);
	*/
	//test_db_register();
	/*
	// insert2 test
	if(0 < insert_into_table2(&mysql, "stm32f303re_info_val", 0x40000004, 0x00000008)) {

		printf("insert_into_table2 failed\n");
		return -1;
	}
	*/

	//test for insert_into_table4
	//insert into stm32f303re_info
	/*
	uint32_t arr1[0x3ff][3] = {
		
		{ 0x00000000, 1, 0}, //0x00
		{ 0x00000000, 1, 0}, //0x04
		{ 0x00000000, 1, 0}, //0x0c
		{ 0x00000000, 3, 0}, //0x4c
		{ 0x00000000, 3, 0xf}, //0x-end sign
	};
	uint32_t addr1 = 0x40000000;
	if(0 > insert_into_table3(&mysql, "stm32f303re_info", addr1, arr1)) {
		printf("insert_into_table3 failed\n");
		return -1;
	}
	//insert into stm32f303re_info_val;
	uint32_t arr2[0x3ff][32] = {
		
		{	//0x00
			0x00000001, 0x00000002, 0x00000004, 0x00000008,
			0x00000010,	0x00000060, 0x00000080,
			0x00000300, 0x00000800
		}
	};
	uint32_t addr2 = 0x40000000;
	if(0 > insert_into_table4(&mysql, "stm32f303re_info_val", addr2, arr2)) {
		printf("insert_into_table3 failed\n");
		return -1;
	}
	// db_regs init
	if(0 > db_register_init(&mysql)) {

		printf("db_register_init failed\n");
		return -1;
	}
	test_db_register();
	//delete and reset auto_increment
	reset_db_register(&mysql);
	*/
#if 0
	//========== Search =============
	char *query = "select val from stm32f303re_info_val where id = \
				   (select id from stm32f303re_info where addr=0x40000000)";
	if(search_from_table(&mysql, query) < 0) {
		printf("query failed !\n");
		return -1;
	}
	//========== Insert =============
	query = "insert student (name, phone) values('zhangsan', '12345678900')";
	if(insert_into_table(&mysql, query) < 0) {
		printf("insert failed\n");
		return -1;
	}
	//========== Insert =============
	query = "delete from student where name='zhangsan'";
	if(delete_from_table(&mysql, query) < 0) {
		printf("delete failed\n");
		return -1;
	}
#endif
	//========== Close =============
	mysql_close(&mysql);
	return 0;
}

#endif

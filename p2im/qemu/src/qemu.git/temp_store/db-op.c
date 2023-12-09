/*
 * Author: Chunlin Wang
 * Date: 2020-10-05
 * E-mail: chunlin_wang01@163.com
 * Des: Some operations about Database 
 */

#include "database/db-op.h"
MYSQL mysql;
db_Register *reg_list = NULL;

/*
 * Init mysql handler and connect to it.
 * return 0 if success, or return -1
 */
int init_mysql(MYSQL *mysql) {

	mysql_init(mysql);
	/*
	 * Here, db_register is common database used to store the register
	 * basic information board-based.
	 */
	MYSQL *ret = mysql_real_connect(mysql, "localhost", "user0", \
					"User0@1357", "db_register", 3306, NULL, 0);
	if(NULL == ret) {
		perror("Fail to connect to mysql\n\n");
        return -1;
	}
	return 0;
}

/*
 * Close the mysql database 
 */
void close_mysql(MYSQL *mysql) {

    mysql_close(mysql);
}

/*
 * Exec sql terminal
 * @mysql: mysql handler
 * @query: cmd string need to be execed.
 * return 0 if success, or return -1.
 */
int exec_mysql_terminal(MYSQL *mysql, char *query) {

    if(mysql_real_query(mysql, query, (uint32_t)strlen(query)) != 0) {
        //perror("exec_mysql_terminal failed\n");
        return -1;
    }
    return 0;
}

/*
 * Get reset value from database according to addr
 * return 0 if success, or return -1
 */
uint32_t get_reset_value(MYSQL *mysql, char *tb, uint32_t addr) {

	char query[100];
	sprintf(query, "select rval from %s where addr = %u", tb, addr);
	if(0 > exec_mysql_terminal(mysql, query)) {
        perror("exec_mysql_terminal failed\n");
		return ERROR_RESET_VAL;
	}
	MYSQL_RES *res = mysql_store_result(mysql);
	if(NULL == res) {
		perror("mysql_store_result error!\n");
		return ERROR_RESET_VAL;
	}
	MYSQL_ROW row = mysql_fetch_row(res);
	return strtoul(row[1], NULL, 10);
}

/*
 * Get db_register structure from database according to addr
 * return 0 when success, or -1
 */
int get_db_register1(MYSQL *mysql, db_Register *db_reg, 
				char *tb, uint32_t addr) {

	
	char query[100];
	sprintf(query, "select * from %s where addr = %u", tb, addr);
	if(0 > exec_mysql_terminal(mysql, query)) {
        perror("exec_mysql_terminal failed\n");
		return -1;
	}
	MYSQL_RES *res = mysql_store_result(mysql);
	if(NULL == res) {
		perror("mysql_store_result error!\n");
		return -1;
	}
	MYSQL_ROW row = mysql_fetch_row(res);
	db_reg->addr = addr;
	db_reg->rval = strtoul(row[1], NULL, 10);
	db_reg->type = atoi(row[2]);
	db_reg->is_special = atoi(row[3]);
	return 0;
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
 *
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
 * Get mysql resources from database
 */
MYSQL_RES *get_reg_resource(MYSQL *mysql, char *query) {

    if(exec_mysql_terminal(mysql, query) < 0) {
        return NULL;
    }
    // read all content from database and store into client
    MYSQL_RES *res = mysql_store_result(mysql);
    if(NULL == res) {
        return NULL;
    }
    return res;
}

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
 * Init db_Register list according to database
 * return 0 if success, or return -1;
 */
int init_reg_list(MYSQL *mysql, char *bdname) {

	if(0 > init_head_node()) {
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
        if(NULL == db_reg) {
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
 * Print register info from reg_list
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


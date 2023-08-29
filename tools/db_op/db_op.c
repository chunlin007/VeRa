
#include "db_op.h"

/*
 * init and connect to mysql database
 * return 0 if success, or return -1
 * @this function is used to unique database, not common
 */
int init_mysql(MYSQL *mysql) {
	
	mysql_init(mysql);
	MYSQL * ret = mysql_real_connect(mysql, "localhost", "user0", \
                    "User0@1357", "db_register", 3306, NULL, 0);
    if(NULL == ret) {
        perror("Fail to connect to mysql\n\n");
        return -1;
    }
	return 0;
}

/*
 * close the mysql hanler
 */
void close_mysql(MYSQL *mysql) {
	
	mysql_close(mysql);
}

/*
 * exec sql terminal
 * @mysql: mysql handler
 * @query: sql terminal need to be execed.
 * return 0 if success, or return -1.
 */
int exec_mysql_terminal(MYSQL *mysql, char *query) {

	if(mysql_real_query(mysql, query, (uint32_t)strlen(query)) != 0) {
		perror("exec_mysql_terminal failed\n");
		return -1;
	}
	return 0;
}

/*
 * insert values into datatable-stm32f303re_info
 * @mysql: mysql handler
 * @addr: where to insert the value
 * @rval: the reset value will be inserted
 * @type: the type of register
 * @is_special: is the register with special meaning ?
 * return 0 if insert success, or return -1
 */
int insert_into_table1(MYSQL *mysql, uint32_t addr, uint32_t rval,
				int type, int is_special) {

	char query[100];
	sprintf(query, "insert into stm32f303re_info (addr, rval, type, is_special) values(%u, %u, %d, %d)", addr, rval, type, is_special);
	if(0 > exec_mysql_terminal(mysql, query)) {
		perror("insert_into_table1 failed\n");
		return -1;
	}
	return 0;
}

/*
 * insert values into datatable-stm32f303re_val
 * @mysql: mysql handler
 * @addr: where to insert the value
 * @val: the value will be inserted
 * return 0 if insert success, or return -1
 */
int insert_into_table2(MYSQL *mysql, uint32_t addr, uint32_t val) {

	char query[100];
	sprintf(query, "insert into stm32f303re_val (addr, val)  \
					values(%u, %u)", addr, val);
	if(0 > exec_mysql_terminal(mysql, query)) {
		perror("insert_into_table2 failed\n");
		return -1;
	}
	return 0;
}

/*
 * reset data table before reconstruct database
 * @tb: table will be reset
 * return 0 if success, or return -1
 */
int reset_table(MYSQL *mysql, char *tb) {

	char query[100];
	sprintf(query, "delete from %s where id > 0", tb);
    if(0 > exec_mysql_terminal(mysql, query)) {
        perror("reset_table-delete failed\n");
        return -1;
    }
	memset(query, 0, 100);
	sprintf(query, "alter table %s auto_increment = 1", tb);
    if(0 > exec_mysql_terminal(mysql, query)) {
        perror("reset_table-auto_increment failed\n");
        return -1;
    }
	return 0;
}


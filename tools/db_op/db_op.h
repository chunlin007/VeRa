#ifndef __DATABASE_OPERATION__
#define __DATABASE_OPERATION__
#include <stdio.h>
#include <mysql/mysql.h>
#include <string.h>
#include <stdint.h>

MYSQL mysql1;

int init_mysql(MYSQL *mysql);
void close_mysql(MYSQL *mysql);
int exec_mysql_terminal(MYSQL *mysql, char *query);
int insert_into_table1(MYSQL *mysql, uint32_t addr, uint32_t rval,
                int type, int is_special);
int insert_into_table2(MYSQL *mysql, uint32_t addr, uint32_t val);
int reset_table(MYSQL *mysql, char *tb);

#endif  //__DATABASE_OPERATION__

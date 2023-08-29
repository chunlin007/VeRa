/*
 * Compare the speed of reading and writing in database and file.
 * complie: gcc compare.c `pkg-config --libs --cflags mysqlclient`
 */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <stdint.h>
#include <mysql/mysql.h>
#include <sys/time.h>

/*
 * search information from database
 */
void search_from_db() {

	MYSQL mysql;
	mysql_init(&mysql);
	MYSQL *ret = mysql_real_connect(&mysql, "localhost", "user0", \
					"User0@1357", "db_register", 3306 , NULL, 0);
	if(NULL == ret) {
		perror("conect to mysql failed\n");
		exit(-1);
	}
	char *query = "select rval from stm32f303re_info where addr = 0x40000000";
	if(mysql_real_query(&mysql, query, (unsigned int)strlen(query))) {
		perror("mysql_real_query failed\n");
		exit(-1);
	}
	MYSQL_RES *res = mysql_store_result(&mysql);
	if(NULL == res) {
		perror("mysql_store_result failed\n");
		exit(-1);
	}
	MYSQL_ROW row = mysql_fetch_row(res);
	//printf("rval = %08lx\n", strtoul(row[0], NULL, 10));
	mysql_close(&mysql);
}

/*
 * search information from file
 */
void search_from_file() {

	FILE *fp = fopen("/tmp/test", "r");
	if(NULL == fp) {
		perror("fopen failed\n");
		exit(-1);
	}
	char buf[100];
	fread(buf, 1, 8, fp);
	//printf("buf = %s\n", buf);
	//printf("rval = %08lx\n", strtoul(buf, NULL, 10));
	fclose(fp);

	
}

int main() {

	int t = 10000;
	struct timeval start1, end1, start2, end2;
	gettimeofday(&start1, NULL);
	while(t > 0) {
		search_from_db();
		t--;
	}
	gettimeofday(&end1, NULL);
	t = 10000;
	gettimeofday(&start2, NULL);
	while(t > 0) {
		search_from_file();
		t--;
	}
	gettimeofday(&end2, NULL);
	time_t sec1 = end1.tv_sec - start1.tv_sec;
	suseconds_t usec1 = end1.tv_usec - start1.tv_usec;
	time_t sec2 = end2.tv_sec - start2.tv_sec;
	suseconds_t usec2 = end2.tv_usec - start2.tv_usec;

	printf("TYPE\t second\tusecond\n");
	printf("Database: %lu\t %lu\n", sec1, usec1);
	printf("File:     %lu\t %lu\n", sec2, usec2);
	return 0;
};

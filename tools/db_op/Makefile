
test:
	gcc db_test.c -o mysqltest `pkg-config --libs --cflags mysqlclient`

db: gen_stm32f303re.c db_op.c datatable.h db_op.h 
	gcc -o db_construct $^ `pkg-config --libs --cflags mysqlclient`

clean:
	rm -rf mysqltest db_construct

.PHONY:
	clean

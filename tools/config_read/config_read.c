/*
 * Author: Chunlin Wang
 * Description: Test suite for getting config information from XX.json
 * Date: 2022-09-08
 */

#ifndef CONFIG_READ
#define CONFIG_READ

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <jansson.h>

#define DEFAULT_FILE "./common_boards.cfg"
#define DEFAULT_NUM 10

typedef struct {

	char  		 *type;		//Callback type name
	unsigned  	 hse;		//Low speed external clock
	unsigned	 lse;		//High speed external clock
	char		 *jpg;		//Callback picture name

}Callback;

typedef struct {
	
	char	     *name;		//Machine name
	char 	     *desc;		//Machine description

}Machine;

typedef struct {

	char 		 *family;
	unsigned	 hse_freq_hz;
	unsigned	 lse_freq_hz;
	unsigned 	 eeprom_size_kb;
	unsigned	 ccm_size_kb;	
	//More inforation
	
}Capabilities;

typedef struct Board{

	Callback callback;
	Machine  machine;
	Capabilities capabilities;
	struct Board *next;

}Board;

/* 
 * Write board configuration from config file(.json)
 * @path: the path of stm32 board config file.
 * return: 0 if read success, or return 1.
 */
static int config_write(const char *path){

	if(!path) {
		fprintf(stderr, "Path is null");
		return 1;
	}
	json_t *root = json_object();
	json_t *call = json_object();
	json_t *mac = json_object();
	json_t *cap = json_object();
	json_t *board = json_object();
	json_t *boardlist = json_object();

	//Callback
	json_object_set_new(call, "type", json_string("STM32F103"));
	json_object_set_new(call, "hse", json_integer(8000000));
	json_object_set_new(call, "lse", json_integer(40000));
	json_object_set_new(call, "jpg", json_string("STM32F103rb.jpg"));
	json_object_set_new(board, "callback", call);

	//Machine
	json_object_set_new(mac, "name", json_string("STM32F103 Board"));
	json_object_set_new(mac, "desc", json_string("STM32F103 Description"));
	json_object_set_new(board, "machine", mac);

	//Capabilities
	json_object_set_new(cap, "family", json_string("STM32_FAMILY_L3"));
	json_object_set_new(cap, "hse_freq_hz", json_integer(8000000));
	json_object_set_new(cap, "lse_freq_hz", json_integer(4000));
	json_object_set_new(cap, "eeprom_size_kb", json_integer(200));
	json_object_set_new(cap, "ccm_size_kb", json_integer(200));
	json_object_set_new(board, "capabilities", cap);

	json_object_set_new(boardlist, "Board1", board);
	json_object_set_new(boardlist, "Board2", board);
	json_object_set_new(boardlist, "Board3", board);
	json_object_set_new(root, "boardlist", boardlist);
	
	//json_dump_file(root, JSON_PRESERVE_ORDER);
	json_dump_file(root, path, JSON_INDENT(4));

	//Trash recall
	if(root)
		json_delete(root);
	if(board)
		json_delete(board);
	if(call)
		json_delete(call);
	if(mac)
		json_delete(mac);
	if(cap)
		json_delete(cap);
	return 0;
}

/* 
 * Read board configuration from config file(.json)
 * @path: the path of stm32 board config file.
 * return: 0 if read success, or return 1.
 */
static int config_read(const char *path){

	if(!path || access(path, F_OK) < 0) {
		fprintf(stderr, "Not find file %s\n", path);
		return 1;
	}
	Board *boardlist = (Board *)malloc(sizeof(Board));
	//memset(boardlist, 0, sizeof(BoardList));
	boardlist->next = NULL;
	Board *head = boardlist;
	json_t *root = NULL;
	//json_t *board = NULL;
	json_t *boardlabel = NULL;
	json_error_t error;
	json_t *board_item;
	const char *board_name;

	root = json_load_file(path, 0, &error);
	if(!json_is_object(root))
		fprintf(stderr,"!json_is_object %s", path);

	boardlabel = json_object_get(root, "boardlist");
	if(!json_is_object(boardlabel))
		fprintf(stderr, "boardlabel is not object");

	json_object_foreach(boardlabel, board_name, board_item) {
		
		printf("board name = %s\n",board_name);
		Board *board = (Board *)malloc(sizeof(Board));
		//board->next = NULL;
		memset(board, 0, sizeof(Board));
		json_t *call = json_object_get(board_item, "callback");
		json_t *mac = json_object_get(board_item, "machine");
		json_t *cap = json_object_get(board_item, "capabilities");

		char *type, *jpg, *name, *desc, *family;
		int hse, lse, hse_freq_hz, lse_freq_hz, eeprom_size_kb, ccm_size_kb;
		
		int status = json_unpack(call, "{s:s, s:i, s:i, s:s}", 
						"type", &type, "lse", &lse, "hse", &hse, "jpg", &jpg
						);
		printf("status = %d\n",status);
		board->callback.type = type;
		board->callback.lse = lse;
		board->callback.hse = hse;
		board->callback.jpg = jpg;

		status = json_unpack(mac,"{s:s, s:s}", "name", &name, "desc", &desc);
		printf("status = %d\n",status);
		board->machine.name = name;
		board->machine.desc = desc;

		status = json_unpack(cap, "{s:s, s:i, s:i, s:i, s:i}", 
						"family", &family, "hse_freq_hz", &hse_freq_hz,
						"lse_freq_hz", &lse_freq_hz,
						"eeprom_size_kb", &eeprom_size_kb,
						"ccm_size_kb", &ccm_size_kb
						);
		printf("status = %d\n",status);
		board->capabilities.family = family;
		board->capabilities.hse_freq_hz = hse_freq_hz;
		board->capabilities.lse_freq_hz = lse_freq_hz;
		board->capabilities.eeprom_size_kb = eeprom_size_kb;
		board->capabilities.ccm_size_kb = ccm_size_kb;

		head->next = board;
		head = head->next;
	}
	
	Board *ptr = boardlist->next;
	//printf("ptr->call->type = %s\n",ptr->callback->type);
	
	while(ptr) {
	
		printf("type = %s\n",ptr->callback.type);
		printf("lse = %d,  hse = %d\n", ptr->callback.lse, ptr->callback.hse);
		printf("jpg = %s\n",ptr->callback.jpg);
		printf("name = %s\n",ptr->machine.name);
		printf("desc = %s\n",ptr->machine.desc);
		printf("family = %s\n", ptr->capabilities.family);
		printf("hse_freq_hz = %d\n", ptr->capabilities.hse_freq_hz);
		printf("lse_freq_hz = %d\n", ptr->capabilities.lse_freq_hz);
		printf("eeprom_size_kb = %d\n", ptr->capabilities.eeprom_size_kb);
		printf("ccm_size_kb = %d\n", ptr->capabilities.ccm_size_kb);
		ptr = ptr->next;
	}
	return 0;
}

int main(){

	if(config_write("./test.json"))
		perror("config_write error\n");
	if(config_read("./test.json"))
		perror("config_read error\n");
	
	return 0;
}

#endif    //CONFIG_READ

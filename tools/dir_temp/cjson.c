#include <stdio.h>
#include <stdlib.h>
#include <jansson.h>
#define FPATH "file.json"


int main() {

	int status = 0;
	json_error_t error;
	json_t *root1 = json_load_file(FPATH, 0, &error);
	if(!root1) {
		fprintf(stdout, "error1: on line: %d, %s\n", error.line, error.text);
		return -1;
	}
	char *bbl_e, *key;
	int sr_num, set_bits, r_idx;
	json_t *jsatisfy, *jval;
	json_object_foreach(root1, key, jval) {
		status = json_unpack_ex(jval, &error, 0, "{s:i, s:i, s?:i, s:o}", 
					"sr_num", &sr_num,
					"set_bits", &set_bits,
					"CR_SR_r_idx", &r_idx,
					"satisfy", &jsatisfy
					);
		if(0 > status) {
			fprintf(stdout, "error3: on line: %d, %s\n", 
				error.line, error.text);
			return -1;
		}
		printf("sr_num = %d, set_bits = %d, CR_SR_r_idx = %d \n",
				sr_num, set_bits, r_idx);
		// satisfy
    	if(!json_is_array(jsatisfy)) {
			fprintf(stderr, "error: satisfy is not an array\n");
    	  	json_decref(root1);
    	  	return -1;
    	}
		json_t *jbc;
		int k;
		#define PM_MAX_SATISFY_NUM 32
		json_array_foreach(jsatisfy, k, jbc) {
    	  	printf("------------------k = %d ----------\n", k);	
			if (k >= PM_MAX_SATISFY_NUM) {
    	    	fprintf(stderr, "error: too many bit combinations \
						in satisfy!\n");
    	    	return -2;
    	  	}

    	  	if(!json_is_array(jbc)) {
    	    	fprintf(stderr, "error: bit combination is not an array\n");
    	    	json_decref(root1);
    	    	return -1;
    	  	}
    	  	json_t *jb;
			int l;
			#define PM_MAX_BIT_COMB_SZ 32
			#define PM_SET_BITS 3
			int satisfy[PM_MAX_SATISFY_NUM][PM_MAX_BIT_COMB_SZ][PM_SET_BITS];
			/*
			json_array_foreach(jbc, l, jb) {
				printf("l = %d\n", l);
    	    	if (l >= (sr_num*2) || l >= (PM_MAX_BIT_COMB_SZ*2)) {
    	      		fprintf(stderr, 
						"error: too many bits in bit combination %d!\n", k);
    	      		return -2;
    	    	}
    	    	int l1;
    	    	l1 = l/2;
    	    	if (l%2 == 0) { // bits
    	    	  	//l1 = l/2;
    	    	  	if (set_bits == 1) {
    	    	    	status = json_unpack_ex(jb, &error, 0, "[i]",
    	    	      	&satisfy[k][l1][1]);
    	    	  	} else if (set_bits == 2) {
    	    	    status = json_unpack_ex(jb, &error, 0, "[i,i]",
    	    	      &satisfy[k][l1][1], &satisfy[k][l1][2]);
    	    	  	} else {
    	    	    	fprintf(stderr, "error: unexpected set_bits");
    	    	    	return -2;
    	    	  	}
    	    	} else { // set/clear
    	    	    status = json_unpack_ex(jb, &error, 0, "i",
    	    	      &satisfy[k][l1][0]);
					printf("set_clear = %d\n", satisfy[k][l1][0]);
    	    	}
    	    	if (status) 
					printf("error\n");
    		} // json_array_foreach
			*/
			json_array_foreach(jbc, l, jb) {
				printf("l = %d\n", l);
    	    	if (l >= (sr_num*2) || l >= (PM_MAX_BIT_COMB_SZ*2)) {
    	      		fprintf(stderr, 
						"error: too many bits in bit combination %d!\n", k);
    	      		return -2;
    	    	}
    	    	int l1;
    	    	l1 = l/2;
    	    	if (l%2 == 0) { // bits
    	    	  	//l1 = l/2;
    	  			if(!json_is_array(jb)) {
    	    			fprintf(stderr, "error: bit combination is not an array\n");
    	    			json_decref(root1);
    	    			return -1;
    	  			}
					int kk = 0, bit;
					json_t *jbit;
					json_array_foreach(jb, kk, jbit) {
						status = json_unpack_ex(jbit, &error, 0, "i", &bit);
						satisfy[k][l1][kk + 1] = bit;
						printf("[%d] = %d  ", kk, bit);
						if(kk + 1 >= PM_SET_BITS) {
    	    	    		fprintf(stderr, "error: unexpected set_bits");
    	    	    		return -2;
						}
					}
					printf("kk = %d\n", kk);
    	    	} else { // set/clear
    	    	    status = json_unpack_ex(jb, &error, 0, "i",
    	    	      &satisfy[k][l1][0]);
					printf("set_clear = %d\n", satisfy[k][l1][0]);
    	    	}
    	    	if (status) 
					printf("error\n");
    		} // json_array_foreach
    	}
	}

	if(root1) {
		json_delete(root1);
	}
	return 0;
}
/*
i		"satisfy": [
            [
                [
                    0
                ],	// SR1-bit
                0,	// set_clear of SR1
                [
                    1
                ],	// SR2-bit
                1	// set_clear of SR2
            ],	// satisfy combination 1
            [
                [
                    2
                ],
                1,
                [
                    3
                ],
                1
            ]	// satisfy combination 1
        ]
*/

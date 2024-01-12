#include "peri-mod/peri-mod.h"
#include "peri-mod/interrupt.h"
#include <jansson.h> // JSON load/dump

/* For fast-prototyping purpose,
 * we use unassigned_mem_read/write, instead of Memory_Region
 */

// Data structure for level 1
pm_Peripheral * volatile pm_PeripheralList = NULL;

// Functions on Level 1 : pm_PeripheralList

// TODO reimplement it in a more efficient way
// may not be necessary as we plan to implement it by MemoryRegion in the future
pm_Peripheral *create_peri(target_ulong reg_addr) {
    pm_Peripheral *peri = g_malloc(sizeof(pm_Peripheral));
    if (!peri)
        printf("%s: malloc failed", __FUNCTION__);

    memset(peri, 0, sizeof(pm_Peripheral));
    // compiler turns this line into reg_addr * PM_PERI_ADDR_RANGE * PM_PERI_ADDR_RANGE
    //peri->base_addr = (reg_addr / PM_PERI_ADDR_RANGE) * PM_PERI_ADDR_RANGE;    
    peri->base_addr = reg_addr & ~(PM_PERI_ADDR_RANGE - 1);

    peri->next = pm_PeripheralList;
    pm_PeripheralList = peri;

    // TODO hardcode DR_bytes_num to 2
    // peri->DR_bytes_num = 2;
    return peri;
}

pm_Peripheral *get_peri(target_ulong reg_addr) {
    pm_Peripheral *peri = pm_PeripheralList;
    // target_ulong base_addr = (reg_addr / PM_PERI_ADDR_RANGE) * PM_PERI_ADDR_RANGE;
    target_ulong base_addr = reg_addr & ~(PM_PERI_ADDR_RANGE - 1);
    while(peri) {
        if (peri->base_addr == base_addr)
            break;
        peri = peri->next;
    }
    return peri;
}

// Functions on level 2: pm_Peripheral
// Empty

// Functions on level 3: pm_MMIORegister
char *pm_rt_str(pm_reg_type_t reg) {
    const char *pm_rt_strings[5] = {"UC", "CR", "SR", "DR", "CR+SR"};
    return pm_rt_strings[reg];
}

// Functions on level 4: pm_Event
// abstract the status val accoring to events
target_ulong get_status_val(pm_Event *, bool); 
target_ulong get_status_val(pm_Event *e, bool is_satisfy) {

	target_ulong ret_val = 0;
   	int i = 0, bit;
   	int set_clear = 0; // 1 means set, 0 means clear
   	if(is_satisfy) {
   	 	set_clear = e->satisfy[e->cur_satisfy][e->cur_sr][0];
   		if (set_clear) {
   		  	while((bit = e->satisfy[e->cur_satisfy][e->cur_sr][i+1]) != -1) {
   		  		ret_val |= 1 << bit;
   		  	  	i++;
   		  	}
   		} 
   	} else {
   	 	set_clear = e->other[e->cur_other][e->cur_sr2][0];
   		if (set_clear) {
   		  	while((bit = e->other[e->cur_other][e->cur_sr2][i+1]) != -1) {
   		  		ret_val |= 1 << bit;
   		  	  	i++;
   		  	}
   		} 
	}
   	return ret_val;
	
}

volatile bool using_other_status = false;
// events manager
target_ulong pm_SR_read(pm_Event *e, pm_MMIORegister *reg) {
	
    target_ulong ret_val = 0;
	bool factor_other = false; 
#ifdef __USING_OTHER_STATUS__
	if(e->satisfy_num == 0 && e->other_num == 0) return 0;
#ifdef __OPEN_STABLE_MODE__
	// This mode can not support Drone
	factor_other = e->num_read % NUM_CHANGE_STATUS == 1; 
#else
	if(pm_rand_sz > 0) {
		int index = e->num_read % pm_rand_sz;
		factor_other = pm_rand[index] % NUM_CHANGE_STATUS == 1; 
	} 
#endif

#else
	if(e->satisfy_num == 0) return 0;
#endif
	e->num_read++;
	e->num_read &= 0x7fffffff;
	//TODO Add factor to enter satisfy more times
	if(e->satisfy_num > 0) {	
#ifdef __USING_OTHER_STATUS__
		if(!e->is_result_hang && 
			e->other_num > 0 && factor_other && 
			e->cur_sr == 0) {
			if(pm_rand_sz > 0 && (e->cur_other == 0 || e->num_read % 23 == 1)) {
				e->cur_other = pm_rand[pm_rand_sz / 2] % e->other_num;
			}
			if(e->num_read % 121 == 0) {
    		    e->cur_other = (e->cur_other + 1) % e->other_num;
			}
			ret_val = get_status_val(e, false);
    		e->cur_sr2 = (e->cur_sr2 + 1) % e->sr_num;
    		if (e->cur_sr2 == 0) {
    		    e->cur_other = (e->cur_other + 1) % e->other_num;
    		}
			using_other_status = true;
			return ret_val;
		}
#endif
		// choose the first satisfy site randomly
		using_other_status = false;
		if(pm_rand_sz > 0 && (e->cur_satisfy == 0 || e->num_read % 23 == 1)) {
			e->cur_satisfy = pm_rand[pm_rand_sz / 2] % e->satisfy_num;
		}
		if(e->num_read % 121 == 0) {
    	    e->cur_satisfy = (e->cur_satisfy + 1) % e->satisfy_num;
		}
		ret_val = get_status_val(e, true);
    	// move to next SR on current srr_site
    	e->cur_sr = (e->cur_sr + 1) % e->sr_num;
    	// current srr_site finishes and move to next satisfy
    	if (e->cur_sr == 0) {
    	    e->cur_satisfy = (e->cur_satisfy + 1) % e->satisfy_num;
    	}
	} else if(e->other_num > 0){
#ifdef __USING_OTHER_STATUS__
		if(!e->is_result_hang && factor_other) {
			if(pm_rand_sz > 0) {
				e->cur_other = pm_rand[pm_rand_sz / 2] % e->other_num;
			}
			if(e->num_read % 121 == 0) {
    		    e->cur_other = (e->cur_other + 1) % e->other_num;
			}
			ret_val = get_status_val(e, false);
    		e->cur_sr2 = (e->cur_sr2 + 1) % e->sr_num;
    		if (e->cur_sr2 == 0) {
    		    e->cur_other = (e->cur_other + 1) % e->other_num;
    		}
		    using_other_status = true;
		}
#endif
	}
    return ret_val;
}

#ifdef __OPEN_MULTI_STATUS__
volatile int fac_index = 0;

//Calculate the factor and judge whether the factor can satisfy this case
//cr_sr use the sr as the last write val
inline bool __attribute__((unused)) is_fac1_sat_func(void) 
{
	bool ret = false;
	if(pm_rand_sz > 0) {
		uint32_t tmp = pm_rand[fac_index++];
    	fac_index &= pm_rand_sz;
		ret = tmp < EFF_FACTOR2;
	} 
	return ret;
}

// Provide right val for firmware
target_ulong pm_CR_read(pm_MMIORegister *reg) 
{
	target_ulong ret_val = 0;
#ifdef __OPEN_CR_SCHEDULE__
	if(!run_from_afl) 
	{
		ret_val = reg->val;
	}
	else
	{
		if(reg->last_op == REG_W || is_fac1_sat_func())
		{
			ret_val = reg->val;
		}
		else 
		{
    		if(reg->num_eval <= 1) 
			{
				ret_val = reg->val;
			} 
			else //if(reg->num_eval > 1) 
			{
    		    int acc_id = 0;
				bool got_val = false;
    		    for(int i = 0; i < reg->num_eval; i++) 
				{
    		        acc_id = reg->last_cr_id % (reg->num_eval);
    		        reg->last_cr_id++;
					if(cur_bbl_s == reg->evals[acc_id].bbl_s && 
						cur_bbl_e == reg->evals[acc_id].bbl_e &&
						acc_id != reg->max_id) 
					{
    		            ret_val = reg->evals[acc_id].val;
						got_val = true;
    		            break;
    		        }
    		    }
				if(!got_val) 
				{
					ret_val = reg->val;	
				}
    		} 
			
		}
	}
#else
	ret_val = reg->val;
#endif
	return ret_val;
}
#endif

pm_Event *pm_SR_find_model(uint32_t bbl_e, pm_Peripheral *peri, pm_MMIORegister *reg) {
    int i, CR_val_idx = 0, np;
    char CR_val[PM_MAX_CR_VAL_BYTE] = {};
    for(i = 0; i <= peri->max_reg_idx; i ++)
        if (peri->regs[i].type == CR || peri->regs[i].type == CR_SR) {
            np = snprintf(CR_val+CR_val_idx, PM_MAX_CR_VAL_BYTE-CR_val_idx,
                "%d:0x%x,", i, peri->regs[i].val);
            CR_val_idx += np;
            if (CR_val_idx >= PM_MAX_CR_VAL_BYTE) {
              fprintf(stderr, "too many CR_val bytes!\n");
              exit(0x80);
            }
        }
    CR_val[CR_val_idx-1] = '\0'; // remove the last ','
    for(i = 0; i < peri->evt_num; i ++)
        if(!strncmp(CR_val, peri->events[i].CR_val, PM_MAX_CR_VAL_BYTE) && 
          (peri->events[i].bbl_e == bbl_e))
          if (reg->type == SR || 
            reg->type == CR_SR && reg->r_idx_in_bbl == peri->events[i].r_idx)
            return &peri->events[i];
    return NULL;
}


// Stage SR_R_EXPLORE
uint32_t *sr_func_ret_addr = NULL;
int is_sr_func_ret_addr(uint32_t pc) {
    // sr_func_ret_addr: NULL terminated array on heap storing sr_func ret_addr
    uint32_t *ret_addr = sr_func_ret_addr;
    if (!ret_addr) return 0;
    while(*ret_addr) {
        if (*ret_addr == pc) return 1;
        ret_addr ++;
    }
    return 0;
}

void stage_termination(pm_stage_t term_stage) {
	 printf("stage_termination\n\n");
     if (pm_stage != term_stage)
        fprintf(stderr, "Expect to terminate stage %d. However, we are on stage: %d!\n",term_stage, pm_stage);
     if (pm_dump_model(pm_PeripheralList))
        fprintf(stderr, "Fail to dump model into file %s\n", model_of);
     if (fclose(trace_f))
        fprintf(stderr, "Fail to close trace file\n");
     if (fclose(reg_acc_f))
        fprintf(stderr, "Fail to close reg_acc file\n");
}

// dump/load model
int pm_dump_model(pm_Peripheral *peri) {
    // returns 0 upon success, otherwise non-zeo
    int ret_val = 0;

    json_t *copy_root, *copy_jperis, *copy_jperi, *copy_aup;
    json_error_t error;
    char hex_str[16]; // we need at most 2+8+1 bytes
    if (model_if) {
        // already validated, no need to redo it
        copy_root = json_load_file(model_if, 0, &error);
        json_unpack(copy_root, "{s:o}", "model", &copy_jperis);

        if (aflFile && (pm_stage == SR_R_ID || pm_stage == SR_R_EXPLORE))
          json_unpack(copy_root, "{s:o}", "access_to_unmodeled_peri", &copy_aup);
    }

    int i;
    json_t *root = json_object();
    json_t *jperis = json_object();
    while(peri) {
        json_t *jperi = json_pack("{s:i, s:i}", 
          "DR_bytes_num", peri->DR_bytes_num, "reg_size", peri->reg_size);

        // regs
        json_t *jregs = json_array(), *jreg;
        for (i = 0; i <= peri->max_reg_idx; i++) {
		  pm_MMIORegister *regi = &peri->regs[i];
          pm_reg_type_t type = regi->type;
          if (type == UC) {
            jreg = json_pack("{s:i}", "type", UC); 
          } else {
            jreg = json_pack("{s:i, s:i, s:i}", "type", type, 
              "read", regi->read, "write", regi->write);
#ifdef __OPEN_MULTI_STATUS__
			if(type == DR) {
			  json_object_set_new(jreg, "dr_locked",
			  	json_integer(regi->dr_locked));
			  goto no_evals_dump;
			}
#endif
			if (type == SR || type == CR_SR) {
              json_object_set_new(jreg, "sr_locked",
                json_integer(regi->sr_locked));
            }
            if (type == CR || type == CR_SR) {
#ifdef __OPEN_MULTI_STATUS__
			  if(peri->hang_in_while_flag) {
              	snprintf(hex_str, 16, "0x%x", peri->regs_back[i].cr_val);
              	json_object_set_new(jreg, "cr_value", json_string(hex_str));
			  } else {
              	snprintf(hex_str, 16, "0x%x", regi->cr_val);
              	json_object_set_new(jreg, "cr_value", json_string(hex_str));
			  }
#else
              snprintf(hex_str, 16, "0x%x", regi->cr_val);
              json_object_set_new(jreg, "cr_value", json_string(hex_str));
#endif
            }
#ifdef __OPEN_MULTI_STATUS__
			json_object_set_new(jreg, "result_hang_in_while",
				json_integer(regi->result_hang_in_while));
			json_object_set_new(jreg, "hang_r_idx_in_bbl",
				json_integer(peri->regs_back[i].hang_r_idx_in_bbl));
no_evals_dump:
			;
#endif
          }
          json_array_append_new(jregs, jreg);
        }
        json_object_set_new(jperi, "regs", jregs);

        char ba[12]; // we need at most 2+8+1 bytes
        snprintf(ba, 12, "0x%x", peri->base_addr);

        // events
        // qemu doesn't change it, so copy from load_model
        json_t *jevents = json_object();
        if (model_if) {
		  copy_jperi = json_object_get(copy_jperis, ba);
          if (copy_jperi)
            jevents = json_object_get(copy_jperi, "events");
        }
        json_object_set(jperi, "events", jevents);

        json_object_set_new(jperis, ba, jperi);

        peri = peri->next;
    }
    // will invoke json_decref(jperis), so cannot be invoked earlier
    json_object_set_new(root, "model", jperis);


    // interrupt
    // also dumped when doneWork is invoked by FUZZER WORKER with arg 
    // PM_UNCAT_REG or PM_UNMOD_SRRS. TODO do we avoid it?
    json_t *jints = json_array(), *jint;
    for (i = 0; i < pm_interrupt->arr_size; i++) {
      jint = json_pack("{s:i, s:i, s:i}", 
	  	"excp_num", pm_interrupt->arr[i].int_num, 
        "enabled", pm_interrupt->arr[i].enabled,
		"result_hang", pm_interrupt->arr[i].result_hang );
      json_array_append_new(jints, jint);
    }
    json_object_set_new(root, "interrupts", jints);


    if (pm_stage == SR_R_ID) {
        json_t *jsr_idx = json_array();
        for (i = 0; i < cur_bbl_SR_r_num; i ++)
            json_array_append_new(jsr_idx, json_integer(stage_term_reg_idx[i]));
#ifdef __OPEN_MULTI_STATUS__
        json_t *jsr_peri = json_array();
        for (i = 0; i < cur_bbl_SR_r_num; i ++)
           json_array_append_new(jsr_peri, json_integer(stage_term_peri_ba[i]));
        json_t *jsrr = json_pack("{s:o, s:i, s:i, s:s, s:i, s:i, s:i, s:i, s:o}", 
            "sr_idx", jsr_idx, 
            "CR_SR_r_idx", CR_SR_r_idx_in_bbl, // if used, non-0
            "sr_num", cur_bbl_SR_r_num, "sr_func", sr_func, 
			"bbl_cnt", bbl_cnt, "cur_excp_num", cur_excp_num,
            "bbl_s", cur_bbl_s, "bbl_e", cur_bbl_e, "peri_base_addr",
			jsr_peri);
#else
        json_t *jsrr = json_pack("{s:o, s:i, s:i, s:s, s:i, s:i, s:i, s:i}", 
            "sr_idx", jsr_idx, 
            "CR_SR_r_idx", CR_SR_r_idx_in_bbl, // if used, non-0
            "sr_num", cur_bbl_SR_r_num, "sr_func", sr_func, "bbl_cnt", bbl_cnt,
            "bbl_s", cur_bbl_s, "bbl_e", cur_bbl_e, "peri_base_addr",
			stage_term_peri_ba);
#endif
        json_object_set_new(root, "sr_read", jsrr);
    }

    if (pm_stage == FUZZING) {
        // log access to unmodeled peripheral. Only invoked when doneWork is 
        // invoked by FUZZER WORKER with arg PM_UNCAT_REG or PM_UNMOD_SRRS
        json_object_set_new(root, "model", copy_jperis);
        // aup: access to unmodeled peripheral
        json_t *jaup = json_pack("{s:i, s:s, s:i, s:i, s:i, s:i}", 
            // unlike SR_R_ID, bbl_cnt doesn't count the bbl where reg_acc happens
            "replay_bbl_cnt", bbl_cnt, "aup_func", lookup_symbol(cur_bbl_e), 
            "peri_base_addr", stage_term_peri_ba[0], 
			"reg_idx", stage_term_reg_idx[0], 
            "CR_SR_r_idx", CR_SR_r_idx_in_bbl, // if used, non-0
            "aup_reason", aup_reason);
        json_object_set_new(root, "access_to_unmodeled_peri", jaup);

        model_of = model_if; // reuse model_if
    }

    // copy "access_to_unmodeled_peri" from model_if
    if (aflFile && (pm_stage == SR_R_ID || pm_stage == SR_R_EXPLORE))
        json_object_set_new(root, "access_to_unmodeled_peri", copy_aup);

    if(json_dump_file(root, model_of, JSON_INDENT(4)))
        ret_val = 1;

    if (model_if) json_decref(copy_root);
    json_decref(root);
    return ret_val;
}

unsigned int replay_bbl_cnt = 0;

int pm_load_model(pm_Peripheral **pm_PList) {
    // returns 0/-1/-2 on success/json loading error/too many XX or conversion error
    pm_Peripheral *plist = NULL;

    json_t *root, *jperis, *jsrr, *jints;
    json_error_t error;
    int status;

    root = json_load_file(model_if, 0, &error);
    if(!root) {
        fprintf(stderr, "error: on line %d: %s\n", error.line, error.text);
        return -1;
    }

    if (pm_stage == SR_R_EXPLORE)
        status = json_unpack_ex(root, &error, 0, "{s:o, s:o, s:o}", 
            "model", &jperis, "sr_read", &jsrr, "interrupts", &jints);
    else
        status = json_unpack_ex(root, &error, 0, "{s:o, s:o}", 
			"model", &jperis, "interrupts", &jints);
    if (status) goto error;

    if(!json_is_object(jperis)) {
        fprintf(stderr, "error: model is not an object\n");
        json_decref(root);
        return -1;
    }

	if(!json_is_array(jints)) {
    	fprintf(stderr, "error: jints is not an array\n");
        json_decref(root);
        return -1;
    }

    int j, k, l;
    const char *base_addr;
    json_t *jperi;
    json_object_foreach(jperis, base_addr, jperi) {
        // each obj is a peri
        pm_Peripheral *peri = g_malloc(sizeof(pm_Peripheral));
        memset(peri, 0, sizeof(pm_Peripheral));
        peri->next = plist;
        plist = peri;

        peri->base_addr = strtol(base_addr, NULL, 0);

        json_t *jregs, *jevents;
        status = json_unpack_ex(jperi, &error, 0, "{s:i, s:i, s:o, s:o}", 
            "DR_bytes_num", &peri->DR_bytes_num, "reg_size", &peri->reg_size, 
            "regs", &jregs, "events", &jevents);
        if (status) goto error;

        // regs
        if(!json_is_array(jregs)) {
            fprintf(stderr, "error: regs is not an array\n");
            json_decref(root);
            return -1;
        }
        peri->max_reg_idx = json_array_size(jregs) - 1;

        json_t *jreg;
        json_array_foreach(jregs, j, jreg) {
            // when reg_type is UC, last 2 k,v don't exist and are not loaded.
            status = json_unpack_ex(jreg, &error, 0, "{s:i, s?:i, s?:i}",
              "type", &peri->regs[j].type, 
              "read", &peri->regs[j].read, "write", &peri->regs[j].write);
            if (status) goto error;

            pm_reg_type_t type = peri->regs[j].type;

            if (type == SR || type == CR_SR) {
              status = json_unpack_ex(jreg, &error, 0, "{s:i}", 
                "sr_locked", &peri->regs[j].sr_locked);
			  if (status) goto error;
            }
			if(type == DR) {
			  status = json_unpack_ex(jreg, &error, 0, "{s?:i}",
			     "dr_locked", &peri->regs[j].dr_locked);
           	  if (status) goto error;
			}
			
#ifdef __OPEN_MULTI_STATUS__
			status = json_unpack_ex(jreg, &error, 0, "{s?:i, s?:i}",
            	"result_hang_in_while", &peri->regs[j].result_hang_in_while,
            	"hang_r_idx_in_bbl", &peri->regs[j].hang_r_idx_in_bbl);
            if(status) {
				goto error;
			}
			if (type == DR || type == UC) {
				goto no_evals_load;
			}
no_evals_load:
			;
#endif
        }

        // events
        if(!json_is_object(jevents)) {
            fprintf(stderr, "error: events is not an object\n");
            json_decref(root);
            return -1;
        }
        const char *CR_val, *key;
        json_t *jval0, *jval;
        json_t *jsatisfy, *jbc, *jb;
#ifdef __OPEN_MULTI_STATUS__
		json_t *jother;
#endif
        peri->evt_num = 0;
        json_object_foreach(jevents, CR_val, jval0) {
          if(!json_is_object(jval0)) {
            fprintf(stderr, "error: events[%s] is not an object\n", CR_val);
            json_decref(root);
            return -1;
          }
          if (strlen(CR_val) > PM_MAX_CR_VAL_BYTE-1) {
            fprintf(stderr, "error: too many bytes in CR_val\n");
            return -2;
          }

          json_object_foreach(jval0, key, jval) {
            if (peri->evt_num >= PM_MAX_EVT_NUM) {
              fprintf(stderr, "error: too many events!\n");
              return -2;
            }
            pm_Event *e = &peri->events[peri->evt_num];

            strncpy(e->CR_val, CR_val, PM_MAX_CR_VAL_BYTE);
            e->bbl_e = strtol(key, NULL, 0);
            if ((errno == ERANGE && (e->bbl_e == LONG_MAX || e->bbl_e == LONG_MIN))|| (errno != 0 && e->bbl_e == 0)) {
              fprintf(stderr, "error: bbl_e conversion failed\n");
              return -2;
            }
#ifdef __OPEN_MULTI_STATUS__
            status = json_unpack_ex(jval, &error, 0, 
		      "{s:i, s:i, s?:i, s?:i, s:o, s:o}", 
              "sr_num", &e->sr_num, "set_bits", &e->set_bits, 
              "CR_SR_r_idx", &e->r_idx, "is_result_hang", &e->is_result_hang,
			  "satisfy", &jsatisfy, 
		  	  "other", &jother);
#else
            status = json_unpack_ex(jval, &error, 0, "{s:i, s:i, s?:i, s:o}", 
              "sr_num", &e->sr_num, "set_bits", &e->set_bits, 
              "CR_SR_r_idx", &e->r_idx, "satisfy", &jsatisfy);
#endif

            // satisfy
            if(!json_is_array(jsatisfy)) {
              fprintf(stderr, "error: satisfy is not an array\n");
              json_decref(root);
              return -1;
            }
            json_array_foreach(jsatisfy, k, jbc) {
              if (k >= PM_MAX_SATISFY_NUM) {
                fprintf(stderr, "error: too many bit combinations in satisfy!\n");
                return -2;
              }

              if(!json_is_array(jbc)) {
                fprintf(stderr, "error: bit combination is not an array\n");
                json_decref(root);
                return -1;
              }
              json_array_foreach(jbc, l, jb) {
                if (l >= (e->sr_num*2) || l >= (PM_MAX_BIT_COMB_SZ*2)) {
                  fprintf(stderr, "error: too many bits in bit combination %d!\n", k);
                  return -2;
                }

                int l1;
                l1 = l/2;
                if (l%2 == 0) { // bits
                  //l1 = l/2;
		  		  int kk = 0;
                  json_t *jbit;
		  		  json_array_foreach(jb, kk, jbit) {
                    status = json_unpack_ex(jbit, &error, 0, "i", 
		  		    	&e->satisfy[k][l1][kk + 1]);
		  		    //if(status) goto error;
                    if(kk + 3 >= PM_SET_BITS) { // bit/set_clear_bit/end bit
                       fprintf(stderr, "error: unexpected set_bits");
                       return -2;
                    }
                  }
		  		  e->satisfy[k][l1][kk + 1] = -1;
                } else { // set/clear
                    status = json_unpack_ex(jb, &error, 0, "i", 
                      &e->satisfy[k][l1][0]);
                }
                if (status) goto error;
              }
            }
            e->satisfy_num = k;

#ifdef __OPEN_MULTI_STATUS__
#ifdef __USING_OTHER_STATUS__
            // other
            if(!json_is_array(jother)) {
              fprintf(stderr, "error: other is not an array\n");
              json_decref(root);
              return -1;
            }
            json_array_foreach(jother, k, jbc) {
              if (k >= PM_MAX_SATISFY_NUM) {
                fprintf(stderr, "error: too many bit combinations in other!\n");
                return -2;
              }

              if(!json_is_array(jbc)) {
                fprintf(stderr, "error: bit combination is not an array\n");
                json_decref(root);
                return -1;
              }
              json_array_foreach(jbc, l, jb) {
                if (l >= (e->sr_num*2) || l >= (PM_MAX_BIT_COMB_SZ*2)) {
                  fprintf(stderr, "error: too many bits in bit combination %d!\n", k);
                  return -2;
                }

                int l1;
                l1 = l/2;
                if (l%2 == 0) { // bits
                  //l1 = l/2;
		  		  int kk = 0;
                  json_t *jbit;
		  		  json_array_foreach(jb, kk, jbit) {
                    status = json_unpack_ex(jbit, &error, 0, "i", 
		  		  		&e->other[k][l1][kk + 1]);
		  		  	//if(status) goto error;
                    if(kk + 3 >= PM_SET_BITS) { // bit/set_clear_bit/end bit
                      fprintf(stderr, "error: unexpected set_bits");
                      return -2;
                    }
                  }
		  		  e->other[k][l1][kk + 1] = -1;
                } else { // set/clear
                    status = json_unpack_ex(jb, &error, 0, "i", 
                      &e->other[k][l1][0]);
                }
                if (status) goto error;
              }
            }
            e->other_num = k;
#endif
#endif
            peri->evt_num ++;
        }
      }
    }
	
	// extract interrupt
	json_t *jint;
	json_array_foreach(jints, j, jint) {
    	//status = json_unpack_ex(jint, &error, 0, "{s:i, s:i, s:i}",
    	status = json_unpack_ex(jint, &error, 0, "{s:i, s:i}",
			"excp_num", &pm_interrupt->arr[j].int_num,
        	//"enabled", &pm_interrupt->arr[j].enabled,
        	"result_hang", &pm_interrupt->arr[j].result_hang );
        	pm_interrupt->arr[j].enabled = 0;
        if(status) goto error;
		pm_interrupt->arr_size = j + 1;
    }

    if (pm_stage == SR_R_EXPLORE) {
        json_t *jitem, *jarr;
        int i;

#ifdef __OPEN_MULTI_STATUS__
        json_t *jsr_idx, *jperi_base_addr;
        status = json_unpack_ex(jsrr, &error, 0, 
			"{s:i, s:i, s:i, s:i, s:o, s:o, s:o}",
            "bbl_e", &srr_site, "CR_SR_r_idx", &CR_SR_r_idx_in_bbl, 
            "bbl_cnt", &target_bbl_cnt, "sr_num", &cur_bbl_SR_r_num_exp,
			"sr_func_ret_addr", &jarr, "sr_idx", &jsr_idx, 
			"peri_base_addr", &jperi_base_addr);
        if (status) goto error;
		if(!json_is_array(jsr_idx)) {
            fprintf(stderr, "error: jsr_idx is not an array\n");
            json_decref(root);
            return -1;
        }
		if(!json_is_array(jperi_base_addr)) {
            fprintf(stderr, "error: jperi_base_addr is not an array\n");
            json_decref(root);
            return -1;
        }
		json_array_foreach(jsr_idx, i, jitem) {
			status = json_unpack_ex(jitem, &error, 0, "i",
				&stage_term_reg_idx_exp[i]);
			if(status) goto error;
		}
		json_array_foreach(jperi_base_addr, i, jitem) {
            status = json_unpack_ex(jitem, &error, 0, "i",
                 &stage_term_peri_ba_exp[i]);
            if(status) goto error;
        }
#else
        status = json_unpack_ex(jsrr, &error, 0, "{s:i, s:i, s:i, s:o}",
            "bbl_e", &srr_site, "CR_SR_r_idx", &CR_SR_r_idx_in_bbl, 
            "bbl_cnt", &target_bbl_cnt, "sr_func_ret_addr", &jarr);
        if (status) goto error;
#endif

        // NULL terminated address array allocated on heap
        sr_func_ret_addr = g_malloc(sizeof(uint32_t) * (json_array_size(jarr)+1));
        json_array_foreach(jarr, i, jitem) {
            status = json_unpack_ex(jitem, &error, 0, "i", sr_func_ret_addr+i); 
            if (status) goto error;
        }
        *(sr_func_ret_addr+i) = NULL;
    }

    // stage 1&2 invoked from forkserver
    // we need aflFile and replay_bbl_cnt to replay until aup
    if (aflFile && (pm_stage == SR_R_ID || pm_stage == SR_R_EXPLORE)) {
        status = json_unpack_ex(root, &error, 0, "{s:{s:i}}", 
            "access_to_unmodeled_peri", "replay_bbl_cnt", &replay_bbl_cnt);
        if (status) goto error;

        if (pm_stage == SR_R_EXPLORE) {
          if (target_bbl_cnt <= replay_bbl_cnt)
            // For SMR, replay must stop before executing the BBL reading SR, 
            // so that after executing the BBL, it can start stage 2, i.e. 
            // set expl_started to 1. SMR may start before replay finish, e.g. 
            // due to cr_ins which deletes all SM for a peripheral. 
            // We gurantee replay finishes in time by: 
            replay_bbl_cnt = target_bbl_cnt - 1;
        }
    }

    json_decref(root);
    *pm_PList = plist;
    return 0;

error:
    fprintf(stderr, "error: on line %d column %d: %s pm_stage: %d\n", 
        error.line, error.column, error.text, pm_stage);
    json_decref(root);
    return -1;
}


pm_Peripheral *pm_reload_model(void) {
    // free previously loaded model
    pm_Peripheral *p = pm_PeripheralList, *q;
    while(p) {
        q = p->next;
        g_free(p);
        p = q;
    }
    pm_PeripheralList = NULL;

    // load model from file again
    static char model_if_buf[80];
    model_if = model_if_buf;
    snprintf(model_if, 80, "%d/peripheral_model.json", run_num);
    if (pm_load_model(&p)) {
        fprintf(stderr, "Fail to reload model from file %s!\n", model_if);
        exit(0x76);
    }
    return p;
}


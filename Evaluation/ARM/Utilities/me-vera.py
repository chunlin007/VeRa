#!/usr/bin/env python3


'''
   P2IM - script to orchestrate model instantiation
   ------------------------------------------------------

   Copyright (C) 2018-2020 RiS3 Lab

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at:

     http://www.apache.org/licenses/LICENSE-2.0

'''

import subprocess,json,sys,os,re,hashlib,signal,atexit,shutil,logging,time,csv
import struct

import configparser
import argparse
from argparse import Namespace
from random import *

# get the end addr of main function
def get_main_end_addr():
    nm = os.path.dirname(cfg.objdump) + "/arm-none-eabi-nm"
    cmd1 = nm + " -n " + cfg.img + " | grep -w '\w\smain' | " + "awk '{print $1}'"
    cmd2 = nm + " -n " + cfg.img + " | grep -w -A1 '\w\smain' | " + "awk '{getline; print $1}'"
    addr1 = "0x" + os.popen(cmd1).read().replace('\n', '')
    addr2 = "0x" + os.popen(cmd2).read().replace('\n', '')
    if addr1 == "0x" and addr2 == "0x":
        cmd1 = nm + " -n " + cfg.img + " | grep '_main' | " + "awk '{print $1}'"
        cmd2 = nm + " -n " + cfg.img + " | grep -A1 '_main' | " + "awk '{getline; print $1}'"
        addr1 = "0x" + os.popen(cmd1).read().replace('\n', '')
        addr2 = "0x" + os.popen(cmd2).read().replace('\n', '')

    cmd3 = cfg.objdump + " -d " + cfg.img + " --start-address=" + addr1 + " --stop-address=" + addr2
    for l in os.popen(cmd3).read().split('\n')[::-1]:
        if "nop" not in l and ".word" not in l and l != "" and  "..." not in l:
            return l.split(':')[0].strip(' ')
    print('')

# detect firmware hang in while(1)
def detect_hang_mode1(lines, func1):

    line = ""
    last_line = ""
    num = 0
    flag = False
    for line in lines:
        if flag is False:
            if func1 not in line:
                continue
            else:
                flag = True
        
        if line == last_line:
            num += 1
        else:
            last_line = line
        if num > 1000:
            return True
    return False

# detect: firmware hang in handle same operations in loop, such as blk led
def detect_hang_mode2(lines, func1):

    list1 = []
    startIndex = 0
    endIndex = 0
    len_lines = len(lines)
    flag = False
    for i in range(0, len_lines):
        if flag is False:
            if func1 not in lines[i]:
                continue
            else:
                flag = True
        if lines[i] not in list1:
            list1.append(lines[i])
        else:
            startIndex = list1.index(lines[i])
            endIndex = i
        if endIndex > 0 and endIndex > startIndex:
            num = 1
            step = endIndex - startIndex
            for j in range(i, len_lines, step):
                if j + step < len_lines:
                    if lines[j : j + step] == list1[startIndex : endIndex]:
                        num += 1
                        if num > 300:
                            return True
                else:
                    break;
    return False

# judge if the sr value cause the firmware hang in while according to trace file
def sr_result_hang_func(filename, func1):

    if os.path.exists(filename):
        lines = open(filename, "r").readlines()
        if len(lines) < 100:
            return False
        elif detect_hang_mode1(lines, func1) is True:
            return True
        elif detect_hang_mode2(lines, func1) is True:
            return True
        else:
            return False
    return False


def cmp(a, b):
    r = 0 if a.__eq__(b) else 1
    return r

def color_print(s, color="green"):
    if color == "green":
        print("\033[92m%s\033[0m" % s)
    elif color == "blue":
        print("\033[94m%s\033[0m" % s)
    elif color == "yellow":
        print("\033[93m%s\033[0m" % s)
    elif color == "red":
        print("\033[91m%s\033[0m" % s)
    else:
        print(s)

def read_config(cfg_f):
    if not os.path.isfile(cfg_f):
        sys.exit("Cannot find the specified configuration file: %s" % cfg_f)
    parser = configparser.ConfigParser()
    parser.read(cfg_f)

    return Namespace(
        qemu_bin    = os.path.abspath(parser.get("qemu", "bin")),
        qemu_log    = parser.get("qemu", "log"),
        len_seeds   = parser.get("qemu", "len_seeds"),
        len_round   = parser.get("qemu", "len_round"),
        hang_mode   = parser.get("qemu", "hang_mode"),
        board       = parser.get("program", "board"),
        mcu         = parser.get("program", "mcu"),
        img         = os.path.abspath(parser.get("program", "img")),
        log_f       = os.path.abspath(parser.get("model", "log_file")),
        retry_num   = parser.getint("model", "retry_num"),
        peri_addr_range = parser.getint("model", "peri_addr_range"),
        objdump     = parser.get("model", "objdump"),
    )


def one_sr_input_gen(sr_bits, one_cnt, one_name, prev_set_bit, set_bits):
    # generate input for one sr
    # @set_bits: number of bits set in each input
    # @prev_set_bit: bit_i+1 < bit_i to avoid duplicate
    one_sr = []
    if set_bits >= 1:
      for i in range(0, prev_set_bit):
        one_sr += one_sr_input_gen(sr_bits, one_cnt+(1<<i), 
          one_name+("%02d+" % i).encode(), i, set_bits-1)
    else:
      # struct.pack: always packs one_cnt 4-byte unsigned int, regardless of sr_bits
      one_sr.append((struct.pack(">I",one_cnt), ("bit:%s," % one_name.decode()[:-1]).encode()))
    return one_sr # [('\xXX\xXX\xXX\xXX', "bit:01+02,")]

def input_f_writer(sr_bits, sr_num, sr_dir, content, fname, set_bits):
    arr = []
    if sr_num >= 1:
        # gen input for 1 SR setting @set_bits bits, and add a baseline
        one_sr = one_sr_input_gen(sr_bits, 0, b"", sr_bits, set_bits)
        one_sr.append((struct.pack(">I",0), ("bit:%s," % ("-1+"*set_bits)[:-1]).encode()))

        for (one_cnt, one_name) in one_sr:
            arr += input_f_writer(sr_bits, sr_num-1, sr_dir,
                content+one_cnt, fname+one_name, set_bits)
    else:
        fname = fname[:-1] # trim last ','
        with open("%s/%s" % (sr_dir, fname.decode()), "wb") as f:
            f.write(content)
        arr.append(fname)
    return arr # flat array of filenames

# exec_trace_sig(srr_info.sr_bits, srr_info.sr_num, s2_dir,b"trace-", set_bits)
def exec_trace_sig(sr_bits, sr_num, trace_dir, fname, set_bits):
    dic = {}
    if sr_num >= 1:
        # gen input for 1 SR setting @set_bits bits, and add a baseline
        one_sr = one_sr_input_gen(sr_bits, 0, b"", sr_bits, set_bits)
        one_sr.append((struct.pack(">I", 0), ("bit:%s," % ("-1+" * set_bits)[:-1]).encode()))

        for (one_cnt, one_name) in one_sr:
            # one_name = "bit:01+02," -> bits_int = "01+02"
            bits_int = one_name[4:-1]
            dic[bits_int.decode()] = exec_trace_sig(sr_bits, sr_num-1, trace_dir, fname+one_name, set_bits)

        s = ""
        d = {}
        for k, v in list(dic.items()):
            # k = "01+02" -> [1, 2]
            k = list(map(int, k.split('+')))
            if v["sig"] not in d:
                d[v["sig"]] = [k]
            else:
                d[v["sig"]].append(k)

        dic["summary"] = d
        dic["sig"] = hashlib.md5(str(dic).encode()).hexdigest()

    else:
        fname = fname[:-1] # trim last ','
        fpath = "%s/%s" % (trace_dir, fname.decode())
        if os.path.exists(fpath) is False:
            dic["sig"] = 0
        else:
            with open(fpath, "r") as f:
                #TODO Chunlin: should not consider the last sumary
                dic["sig"] = hashlib.md5(f.read().encode()).hexdigest()
    # dic = {"AB+CD":{nested dic}, "sig":sig, "summary":{sig:[[bits],]}}
    return dic

def driver_checked_bits(sr_num, trace_sig, set_bits, is_asyn_func, sr_result_hang, bit_s = "", check_mode = False):
    arr = []
    if sr_num >= 1:
        # cnt = [[count, [[SR1_bitx, SR1_bity]]],], count is only used in print
        # without count, we can merge cnt[] and bits[]
        cnt = []
        max_cnt = 0
        max_idx = -1

        # each checked bit will incur a distinct trace
        # unchecked bits share the same, most common trace.
        for v in list(trace_sig["summary"].values()):
            if len(v) > max_cnt:
                max_cnt = len(v)
                max_idx = len(cnt)
            cnt.append([len(v), [v[0]]])
            #cnt.append([len(v), v])
        
        # handle asynchronized func, such as irq_handler
        if is_asyn_func == 1 and sr_result_hang != {} and check_mode is True:
            # [1] Add all paths to bits and then use dynamicly sechedule them?
            # [2] Only add the path that can not lead to error(while).
            # XXX We now use second strategy
            cnt_del = 0
            for item in cnt:
                for i in item[1]:
                    iname = ""
                    if bit_s != "":
                        iname = bit_s + ","
                    iname = iname + "bit:" + '+'.join([str(j).zfill(2) for j in i])
                    #print(iname)
                    exist_hang = True
                    for ii in sr_result_hang.keys():
                        # if there is exist bit combination that can not result hang
                        if ii.find(iname) == 0 and sr_result_hang[ii] is False:
                            exist_hang = False
                            break
                            
                    if exist_hang is True:
                        del cnt[cnt_del]
                        break
                cnt_del += 1
            
        else:
            # delete the most common trace, and cnt only contains chekced bits
            del cnt[max_idx]
        
        # only contains checked bits
        bits = []
        for c in cnt:
            bits += c[1]
        bits.sort()
        print("%d-th from the last sr: checked bits: %s" % (sr_num, bits))
        trace_sig["checked_bits"] = bits

        if len(bits) == 0:
            color_print("\tNo bits are checked! May not be a SR!", "red")

        # instead of randomly pick an unchecked bits, we use -1
        # we assume -1 is not in bits[]. TODO justify it
        baseline = [-1]*set_bits
        if baseline in bits:
            color_print("\tUnexpected: -1 is in checked bits!", "red")

        for bit in [baseline] + bits:
            # bit = [AB,CD] -> bit_s = 'AB+CD'
            bit_s = '+'.join([str(x).zfill(2) for x in bit])
            bit_ss = "bit:" + bit_s
            arr2 = driver_checked_bits(sr_num-1, trace_sig[bit_s], set_bits, is_asyn_func, sr_result_hang, bit_ss, check_mode)
            for a in arr2:
                a.insert(0, bit)
            # arr = [[[SR1_bitx, SR1_bity], ..., [SRn_bitx, SRn_bity]],]
            arr += arr2
    else:
        arr.append([])
    return arr

def alarm_handler(signo, frame):
   global timeout
   timeout = True

#0x30 : stage_termination(SR_R_ID)
def qemu_run(cmd, retry_num, stage):
    rv = {1: [0x20, 0x19, 0x30], 2: [0x21, 0x23],
          1.1: [0x20, 0x30]}
    error_rv = {2: {0x24: "Cannot find SR Model which is supposed to exist"}, 1.1: {0x19: "Reg type conflict"}}

    run_num = 0
    timeout_num = 0
    while run_num < retry_num:
        signal.signal(signal.SIGALRM, alarm_handler)
        signal.alarm(5)
        with open(os.devnull, 'w') as devnull:
            #ret_val = subprocess.call(cmd, stdout=devnull, stderr=devnull)
            proc = subprocess.Popen(cmd, stdout=devnull, stderr=devnull)
        global timeout
        timeout = False
        proc.wait()
        ret_val = proc.returncode
        if not timeout:
            signal.alarm(0)
        else:
            timeout_num += 1
            if timeout_num == 3: # and stage == 2:
                print("timeout happens, terminate automaically")
                signal.alarm(0)
                if stage == 1:
                    return 0x30
                elif stage == 2:
                    return 0x23
            continue
        print("ret_val: 0x%x" % ret_val)
        if ret_val in rv[stage]:
            return ret_val
        color_print("ret_val == 0x%x, re-run it!" % ret_val, "red")
        run_num += 1

    if stage == 2 and ret_val == 0xff:
        return 0x23
    color_print(error_rv[stage][ret_val], "red")
    sys.exit("Stage %d returned due to unexpected reasons!" % stage)

def cnt_bbl_cov(trace_f):
    bc = {}
    # bc = {(hex_str(bbl_s), hex_str(bbl_e)): cnt}
    bbls = re.findall('BBL \((0x[0-9a-f]+), (0x[0-9a-f]+)\)', open(trace_f).read())
    for bbl in bbls:
        if bbl in bc:
            bc[bbl] += 1
        else:
            bc[bbl] = 1
    return bc

def sig_handler(signo, stack_frame):
    # kill all qemu instances forked
    subprocess.call(["killall", cfg.qemu_bin])
    color_print("py script is killed!", "yellow")
    sys.exit("py script is killed!")

def model_stat(model):
    peri_l = list(model["model"].keys())
    evt_peri_l = [k for k,v in list(model["model"].items()) if len(v["events"])]

    stat = {"peri_num": len(peri_l), "peri_list": sorted(peri_l), 
            "peri_with_event_num": len(evt_peri_l), 
            "peri_with_event_list": sorted(evt_peri_l)}
    return stat

def exit_callback():
    # for running P2IM test cases for DICE
    color_print(last_cmd, "red")
    with open("dma_trace", "w") as f:
         subprocess.call(last_cmd, stdout=f, stderr=f)

    color_print("\nexit_callback is invoked")
    json.dump(rc_adjusted_sum, open("rc_adjusted_sum" ,"w"), sort_keys=True, indent=4)

    bbl_cov_j = {}
    for k,v in list(bbl_cov.items()):
      bbl_cov_j[str(k)] = v
    json.dump({"bbl_cov": bbl_cov_j, "bbl_num": len(bbl_cov_j)}, open("bbl_cov", "w"), indent=4)

    # copy model to peripheral_model.json
    model_of_final = "peripheral_model.json"
    if last_peri_model:
        # sanitize the extracted model and copy to model_of_final
        model = json.load(open(last_peri_model))
        model.pop("sr_read", None)

        m = model["model"]
        for peri in list(model["model"].values()):
          for reg in peri["regs"]:
            reg.pop("cr_value", None)

        if args.run_from_fs != "0":
          del model["access_to_unmodeled_peri"]

        # calculate statistics
        stat = model_stat(model)
        model["statistics"] = stat

    else:
        # dump an empty model
        model = {"model":{}}

    # calculate metrics
    if args.gt:
        json.dump(model, open(model_of_final, "w"), sort_keys=True, indent=4)
        import statFp3
        model["metrics"] = statFp3.getStat(model_of_final, args.gt, "metric.csv")

    json.dump(model, open(model_of_final, "w"), sort_keys=True, indent=4)
    print('')

    # calculate time of execution
    exec_time = time.time() - start_time
    color_print("Execution time(seconds): ")
    print(exec_time)
    if args.run_from_fs != "0":
        logging.info("execution time: %f" % exec_time)

def adjusted_reg_cat(rc_diff):

    rca = {"cr_del": [], "cr_ins": [], "sr_del": [], "sr_ins": []}
    for k,v in list(rc_diff.items()):
      ot = v["old"]["type"]
      nt = v["new"][0]["type"]
      # for CR_SR, CR->CR_SR is the only adjustment allowed currently
      # so we only handle this case
      if ot != nt:
        if ot == 1 and nt != 4: # CR->CR_SR is not cr_del
          rca["cr_del"].append(k)
        if ot == 2:
          rca["sr_del"].append(k)
        if nt == 1 or nt == 4 and ot != 1:
          # CR_ins include both adjusted to and newly cat'd CR
          rca["cr_ins"].append(k)
        #if nt == 2:
          # TODO SR_ins include both adjusted to and newly cat'd SR
        if nt == 2 and ot != 0:
          rca["sr_ins"].append(k)

    for v in list(rca.values()):
      if v:
        return (rca, True) # 2nd param: adjusted
    return (rca, False)
 
# Prereq-->mn["model"][peri_ba0]["events"]
# rca-->rc_adjusted = {"cr_del":[], "cr_ins":[], "sr_del":[], "sr_ins":[]}
def handle_sr_cr_del(prereq, rca):
    
    prereq_upd = {}
    for peri_cfg, v in list(prereq.items()):
      # peri_cfg = "CR_val", v = {srr_site:{}}

      # delete all reg in cr_del from CR_val
      if peri_cfg:
        peri_cfg_upd = []
        for cr in peri_cfg.split(','):
          bit, value = cr.split(':')
          if bit not in rca["cr_del"]:
            peri_cfg_upd.append((int(bit), value))

        CR_val = ""
        for cr_upd in peri_cfg_upd:
          CR_val += "%d:%s," % (cr_upd[0], cr_upd[1])
        CR_val = CR_val[:-1] # trim the ',' at the end
      else:
        # peri_cfg == ""
        CR_val = peri_cfg

      # delete all srr_site extracted due to any reg in SR_del
      # XXX may not complete because the new path may not exists
      v_upd = {}
      for srr_site, v1 in list(v.items()):
        v2 = {
              "never_satisfy" : [],
              "other" : [],
              "satisfy": [],
              "set_bits" : v1["set_bits"],
              "sr_idx" : [],
              "sr_num" : v1["sr_num"]
        }
        l1 = []
        sr_num_new = 0
        for i in range(0, v1["sr_num"]):
          if v1["sr_idx"][i] not in rca["sr_del"]:
            l1.append(i)
            sr_num_new += 1
        if l1 == []: # all sr were del
          continue
        for val in v1["never_satisfy"]:
          val1 = []
          for i in l1:
            val1.append(val[2 * i])
            val1.append(val[2 * i + 1])
          v2["never_satisfy"].append(val1)
        for val in v1["other"]:
          val1 = []
          for i in l1:
            val1.append(val[2 * i])
            val1.append(val[2 * i + 1])
          v2["other"].append(val1)
        for val in v1["satisfy"]:
          val1 = []
          for i in l1:
            val1.append(val[2 * i])
            val1.append(val[2 * i + 1])
          v2["satisfy"].append(val1)
        for i in l1:
          v2["sr_idx"].append(v1["sr_idx"][i])
        v2["sr_num"] = sr_num_new
        v_upd[srr_site] = v2
      if v_upd != {}:
        prereq_upd[CR_val] = v_upd

    return prereq_upd


# Try to run firmware using Qemu and collect return code 
def stage1(redo=False):
    global model_if, model_of, bbl_cov, model_if_s1
    global last_cmd
    # global args, cfg, depth, stage_str, cmd_base
    stage = 1 if not redo else 1.1
    model_if = model_of if depth > 1 or redo else args.model_if
    model_of = "model-depth:%s,stage:%.1f.json" % (depth,stage)
    trace_f = "trace-depth:%s,stage:%.1f" % (depth,stage)
    reg_acc_f = "reg_acc-depth:%s,stage:%.1f" % (depth,stage)
    color_print("depth %d, stage: %s" % (depth, stage_str[stage]), "blue")

    cmd = cmd_base + ["-pm-stage", str(int(stage)), 
      "-trace", trace_f, "-reg-acc", reg_acc_f,
      "-model-output", model_of]
    if model_if:
      cmd += ["-model-input", model_if]
    if args.run_from_fs != "0":
      cmd += ["-aflFile", args.afl_file]
    print("cmd: %s" % ' '.join(cmd))
    last_cmd = cmd
    ret_val = qemu_run(cmd, cfg.retry_num, stage)
    #sys.exit(-1)
    bbl_cov = cnt_bbl_cov(trace_f)
    model_if_s1 = model_if
    print('')
    return ret_val


# Update model.json by comparing old and new json file
def stage1_4():
    global model_if, model_of, rc_adjusted_sum
    # global depth, stage_str, model_if_s1

    stage = 1.4
    model_if = model_of
    model_of = "model-depth:%s,stage:%.1f.json" % (depth,stage)
    #color_print("depth %d, stage: %s" % (depth, stage_str[stage]), "blue")
    print("stage1_4")

    if os.path.exists(model_if) is False:
        sys.exit()
    mn = json.load(open(model_if), strict=False) # model_of of stage 1
    cr_ins_happen = False
    if model_if_s1: # model_if of stage 1
      # always True except depth 1 under an empty --model-if
      mo = json.load(open(model_if_s1))
      for peri_ba0 in mo["model"]:
        # not in 1st depth of a peripheral,
        # where every reg is newly categorized and cannot be adjusted
        color_print("peri_ba: %s" % peri_ba0)

        # rc_diff = {reg_idx: {old: {type:, r/w/:, attr:}, new: [{type:, r/w:, attr:}]}}
        # maintain the same structure with stage 2
        rc_diff = {}
        old = mo["model"][peri_ba0]["regs"]
        new = mn["model"][peri_ba0]["regs"] # new is dumped
        # extend old to the same length with new
        for i in range(len(old), len(new)):
          old.append({"type": 0})
        for i in range(0, len(new)):
          # don't consider cr_value when cmp two reg cat
          old[i].pop("cr_value", None)
          old[i].pop("result_hang_in_while", None)
          old[i].pop("hang_r_idx_in_bbl", None)
          new_i = dict(new[i]) # copy new[i] to avoid del cr_val in orig copy
          new_i.pop("cr_value", None)
          new_i.pop("result_hang_in_while", None)
          new_i.pop("hang_r_idx_in_bbl", None)
          if cmp(old[i], new_i) != 0: # not equal
            rc_diff[i] = {"old": old[i], "new": [new_i]}

        if rc_diff != {}:
          color_print("Register category updates since last srr: ")
          json.dump(rc_diff, sys.stdout, indent=4)

        # detect rc adjusted
        # rc_adjusted = {"cr_del":[], "cr_ins":[], "sr_del":[], "sr_ins":[]}
        (rc_adjusted, adjusted) = adjusted_reg_cat(rc_diff)
        if adjusted:
          k = "depth:%s,stage:%.1f" % (depth,stage)
          if k not in rc_adjusted_sum:
            rc_adjusted_sum[k] = {peri_ba0: rc_adjusted}
          else:
            rc_adjusted_sum[k][peri_ba0] = rc_adjusted
          color_print("Register category adjusted: ")
         # print(rc_adjusted)

          if rc_adjusted["cr_ins"]:
            color_print("cr_ins observed, restart ME with reg cat "
              "extracted!\n", "yellow")
            cr_ins_happen = True
            mn["model"][peri_ba0]["events"] = {}
            # since restart with empty prereq for peri w/ cr_ins, 
            # no need to do the following adjustment
            continue

          if rc_adjusted["cr_del"] or rc_adjusted["sr_del"]:
            color_print("cr/sr_del observed, adjust prereq!", "yellow")
            mn["model"][peri_ba0]["events"] = \
              handle_sr_cr_del(mn["model"][peri_ba0]["events"], rc_adjusted)
          if rc_adjusted["sr_ins"]:
            # TODO
            cr_ins_happen = True
            mn["model"][peri_ba0]["events"] = {}
            color_print("sr_ins observed, redo stage 1 of current depth!\n", 
              "yellow")

        else:
          color_print("No register category adjustment")
        print('')
      # end of for peri_ba0 in mo["model"]

    json.dump(mn, open(model_of, "w"), indent=4)
    print('')
    return cr_ins_happen


# Collect sr info that will be used to explore executation later
def stage1_5():
    global model_if, model_of
    # global depth, stage_str
    stage = 1.5
    model_if = model_of
    model_of = "model-depth:%s,stage:%.1f.json" % (depth,stage)
    #color_print("depth %d, stage: %s" % (depth, stage_str[stage]), "blue")
    print("stage1_5")

    model = json.load(open(model_if))
    sr_r = model["sr_read"]
    sr_num1 = sr_r["sr_num"]
    # correlate sr to peripherals
    # peri_ba1 = [hex(addr) for addr in sr_r["peri_base_addr"]]
    peri_ba1 = sr_r["peri_base_addr"]
    sr_idx1 = sr_r["sr_idx"]
    cur_excp_num = sr_r["cur_excp_num"]
    
    sr_byte = model["model"][hex(peri_ba1[0])]["reg_size"] 
    # strip repeat op, expecially in sdk
    peri_ba = []
    sr_idx = []
    sr_num = 0
    reg_list = []
    for i in range(0, sr_num1):
        addr_reg = peri_ba1[i] + sr_idx1[i] * sr_byte
        if addr_reg not in reg_list:
            reg_list.append(addr_reg)
            peri_ba.append(hex(peri_ba1[i]))
            sr_idx.append(sr_idx1[i])
            sr_num = sr_num + 1

    if sr_num not in list(range(1,7)): # assume at most 4 SR
        sys.exit("Unexpected SR cnt: %d" % sr_num)

    # if > 0 (checked at stage2_5), CR_SR (at most 1) requires SMR
    CR_SR_r_idx = sr_r["CR_SR_r_idx"]

    # CR_val
    CR_val = []
    for addr in peri_ba:
        CR_val1 = ""
        regs = model["model"][addr]["regs"]
        for i in range(0, len(regs)):
            if regs[i]["type"] == 1 or regs[i]["type"] == 4:
                CR_val1 += "%d:%s," % (i, regs[i]["cr_value"])
        CR_val.append(CR_val1[:-1]) # trim the ',' at the end
    
    # use bbl_e to denote SR readsite
    srr_bbl_e = hex(sr_r["bbl_e"]) # int -> hex_str = '0x...'
    # number of bits in SR
    sr_bits = sr_byte * 8
    # evaluation only
    srr_bbl_cnt = sr_r["bbl_cnt"]
    srr_func = sr_r["sr_func"]
    # determine when to terminate worker of stage 2
    objdump = subprocess.check_output([cfg.objdump, "-dC", cfg.img])
    callsites = re.findall("<%s>\n *([0-9a-f]+?):" % sr_r["sr_func"], objdump.decode("utf-8") )
    list1 = []
    for i in callsites:
        if int(i, 16) not in list1:
             list1.append(int(i, 16))
    sr_r["sr_func_ret_addr"] = list1
    # judge whether the func is asynchronized (no func call it)
    print("list1 = %s" %list1)
    is_asyn_func = False
    if list1 == [] and "IRQ" in srr_func: 
        is_asyn_func = True
        print("Catched the asynchronized function: %s" % srr_func)
    # patch for Soldering_Iron
    if "ADC_DMAConvCplt" in srr_func:
        is_asyn_func = False
	# if result hang in while when identify reg
    result_hang_in_while = model["model"][peri_ba[0]]["regs"][sr_idx[0]]["result_hang_in_while"]
    json.dump(model, open(model_of, "w"), indent=4)
    color_print("bbl_cnt, peri_ba, sr_idx, peri_cfg, bbl_id, srr_func:")
    print('%d: %s, %s, %s, %s, %s' % \
      (srr_bbl_cnt, peri_ba, sr_idx, CR_val, srr_bbl_e, srr_func))
    print('')
    return Namespace(
        sr_num       = sr_num,
        peri_ba      = peri_ba,
        sr_idx       = sr_idx,
        CR_SR_r_idx  = CR_SR_r_idx,
        CR_val       = CR_val,
        srr_bbl_e    = srr_bbl_e,
        sr_bits      = sr_bits,
        srr_bbl_cnt  = srr_bbl_cnt,
        srr_func     = srr_func,
        result_hang_in_while = result_hang_in_while,
        is_asyn_func = is_asyn_func,
        cur_excp_num  = cur_excp_num
    )


# Create init sr inputs by exploring execution according to
# sr info collected last stage 
# return input dir and input files
def stage1_9(srr_info, inv_num=1):
    global model_if, model_of
    # global depth, stage_str
    stage = 1.9
    color_print("depth %d, stage: %s" % (depth, stage_str[stage]), "blue")
    # prepare input files
    sr_dir = "sr_input-depth:%d" % depth
    if inv_num > 1:
        color_print("\tinvocation number: %d" % inv_num, "blue")
        sr_dir += ",invoc:%d" % inv_num
    if not os.path.exists(sr_dir):
        os.makedirs(sr_dir)

    #set_bits = 2 if inv_num == 3 else 1
    #set_bits = inv_num - 1 if inv_num >= 3 else 1
    set_bits = inv_num
    fname_l = input_f_writer(srr_info.sr_bits, srr_info.sr_num, sr_dir, b"", b"",set_bits)
    print('')
    return sr_dir, fname_l

# Get callsite status register used by disassembling firmware.elf 
# And catch return code as term-cond using status input dir/files generated pre
def stage2(srr_info, sr_dir, fname_l, inv_num=1, two_ret=0):
    global model_if
    # global args, cfg, depth, stage_str, model_of

    stage = 2
    model_if = model_of
    color_print("depth %d, stage: %s" % (depth, stage_str[stage]), "blue")

    s2_dir = "depth:%d,stage:%.1f" % (depth,stage)
    if inv_num > 1:
        color_print("\tinvocation number: %d" % inv_num, "blue")
        s2_dir += ",invoc:%d" % inv_num
    if not os.path.exists(s2_dir):
        os.makedirs(s2_dir)

    if two_ret == 1: # XXX tentative impl
        model = json.load(open(model_if))
        sr_r = model["sr_read"]
        '''
        Chunlin: If there are more than one SR_r in one BBL, the qemu will
                 dump the last sr_func to sr_read. But this think is error
                 because there will be only func in one BBL.
        '''
        objdump = subprocess.check_output([cfg.objdump, "-dC", cfg.img])
        objdump = objdump.decode()
        func_l = re.findall("([0-9a-f]+) <(.*?)>:", objdump) # [(addr, name)]

        callsites1 = re.findall("<%s>\n *([0-9a-f]+?):" % sr_r["sr_func"], objdump)
        callsites2 = []
        # Chunlin: callsite1->callsite where call func that handles SR
        #          callsite2->func which contain callsite1
        # Useless when firmeware is stripping  
        for cs1 in callsites1:
            # figure out funct of cs1
            for i in range(0, len(func_l)):
                if int(func_l[i][0], 16) > int(cs1, 16):
                    break
            func_name = func_l[i-1][1]
            callsites2 += re.findall("<%s>\n *([0-9a-f]+?):" % func_name, objdump)
        
        list1 = []
        for i in callsites2:
            if int(i, 16) not in list1:
                list1.append(int(i, 16))
        sr_r["sr_func_ret_addr"] = list1
        color_print("func_ret == 2, Return addr: ", "yellow")
        #print(callsites2)
        if not callsites2:
          color_print("empty return addr for func_ret == 2!", "red")

        json.dump(model, open(model_of, "w"), indent=4)

    # run program and collect feedback(written to file)
    # term_cond0 = {fname: ret_val}
    term_cond0 = {}
    sr_result_hang = {}
    for fname_b in fname_l:
        fname=fname_b.decode()
        sr_input = "%s/%s" % (sr_dir,fname)
        trace_f = "%s/trace-%s" % (s2_dir,fname)
        reg_acc_f = "%s/reg_acc-%s" % (s2_dir,fname)
        # TODO data_flow
        model_of1 = "%s/model-%s.json" % (s2_dir,fname)
        print("fname: %s," % fname, end=' ')

        cmd = cmd_base + ["-pm-stage", str(stage), "-sr-input", sr_input,
            "-trace", trace_f, "-reg-acc", reg_acc_f,
            "-model-input", model_if, "-model-output", model_of1]
        if args.run_from_fs != "0":
            cmd += ["-aflFile", args.afl_file]
        #Enable the following line for debugging of the executed command
        #print ("cmd: %s" % ' '.join(cmd))

        ret_val = qemu_run(cmd, cfg.retry_num, stage)
        term_cond0[fname] = ret_val
        '''
       	sr_result_hang[fname] = sr_result_hang_func(trace_f, srr_info.srr_func)
        '''
        if srr_info.is_asyn_func:
        	sr_result_hang[fname] = sr_result_hang_func(trace_f, srr_info.srr_func)
    print(' ')
    if srr_info.is_asyn_func:
        print("sr_result_hang:")
        print(sr_result_hang)
    return s2_dir, term_cond0, sr_result_hang


# Identify and handle register category changes during SR_R_EXPLORE
def stage2_2(srr_info, s2_dir, fname_l, inv_num=1):
    # update model.json for registers whose category is changed during PI
    global model_if, model_of
    # global depth, stage_str

    stage = 2.2
    # use same model_if with stage 2.0(i.e. model_of of stage 1.5)
    model_if = model_if
    model_of = "model-depth:%s,stage:%.1f.json" % (depth,stage)
    color_print("depth %d, stage: %s" % (depth, stage_str[stage]), "blue")

    if inv_num > 1:
        color_print("\tinvocation number: %d" % inv_num, "blue")
        model_of = "model-depth:%s,invoc:%d,stage:%.1f.json" % \
          (depth,inv_num,stage)

    # summarize register type updated(new categorized reg+recategorized reg)
    '''
    rc_diff = {reg_idx: {old: {type:, r/w/:, attr:}, new: [{type:, r/w:, attr:, fname:[]}]}}
    rc_diff is complex as for same old, there could be multiple new,
    for same new, there might be multiple fname
    '''
    model = json.load(open(model_if))
    # XXX only check rc changed for current peri. It's very rare that rc of
    # other peri is changed during worker run
    peri_visited = [] # to prevent to analysis the same peri
    for base in srr_info.peri_ba:
        if base in peri_visited:
            continue
        else:
            peri_visited.append(base)
        rc_diff = {}
        old = model["model"][base]["regs"] # old is dumped
        for fname_b in fname_l:
            fname=fname_b.decode()
            model_of1 = "%s/model-%s.json" % (s2_dir, fname)
            if os.path.exists(model_of1) is False:
                continue
            new = json.load(open(model_of1))["model"][base]["regs"]
            # extend old to the same length with new
            for i in range(len(old), len(new)):
                old.append({"type": 0})
            for i in range(0, len(new)):
                # don't consider cr_value when cmp two reg cat
                old[i].pop("cr_value", None)
                new[i].pop("cr_value", None)
                old[i].pop("result_hang_in_while", None)
                old[i].pop("hang_r_idx_in_bbl", None)
                new[i].pop("result_hang_in_while", None)
                new[i].pop("hang_r_idx_in_bbl", None)
                if cmp(old[i], new[i]) != 0: # not equal
                    if i not in rc_diff:
                        new[i]["fname"] = [fname]
                        rc_diff[i] = {"old": old[i], "new": [new[i]]}
                    else:
                        # we don't change old as it is always the same
                        found_same_new = False
                        for n in rc_diff[i]["new"]:
                            # don't consider fname when cmp two reg cat
                            n2 = dict(n)
                            del n2["fname"]
                            if cmp(n2, new[i]) == 0: # equal
                                n["fname"].append(fname)
                                found_same_new = True
                                break
                        if found_same_new is False:
                            new[i]["fname"] = [fname]
                            rc_diff[i]["new"].append(new[i])

        if rc_diff != {}:
            color_print("Peri %s register category changed in PI: " % base)
            json.dump(rc_diff, sys.stdout, indent=4)
        # update reg cat in json
        for k in rc_diff:
            new_types = set([i["type"] for i in rc_diff[k]["new"]])
            if len(new_types) > 1:
                color_print("Multiple new categories are assigned to: %d"%k, "red")
                print("Category not updated")
            else:
                # XXX assume sr_locked can be changed from 0 to 1, 
                # not the other way
                r,w,sr_locked = 0,0,0
                new_type = new_types.pop()
                for i in rc_diff[k]["new"]:
                    if i["read"]:
                        r = i["read"]
                    if i["write"]:
                        w = i["write"]
                    if new_type in [2, 4] and i["sr_locked"]:
                        sr_locked = i["sr_locked"]
                # upd cat by rewrite old[k]
                old[k] = {"type": new_type, "read": r, "write": w}
                if new_type in [2, 4]:
                    old[k]["sr_locked"] = sr_locked

    json.dump(model, open(model_of, "w"), sort_keys=True, indent=4)
    print('')
    return


def stage2_4(srr_info, s2_dir, inv_num = 1, sr_result_hang = {}, check_mode = False): # inv_num is unused
    # figure out what bits are checked by grouping execution trace by md5
    # if a bit is checked, execution trace differs when it is set or not set
    # global depth, stage_str

    stage = 2.4
    color_print("depth %d, stage: %s" % (depth, stage_str[stage]), "blue")
    set_bits = inv_num

    # trace_sig = {"AB+CD":{nested dic}, "sig":sig, "summary":{sig:[[bits],]}}
    trace_sig = exec_trace_sig(srr_info.sr_bits, srr_info.sr_num, s2_dir, 
        b"trace-", set_bits)

    # driver_checked_bits: returns checked bit combinations to checked_bcs,
    # and inserts "checked_bits" key into trace_sig
    checked_bcs1 = driver_checked_bits(srr_info.sr_num, trace_sig, set_bits, srr_info.is_asyn_func, sr_result_hang, "", check_mode)
    # trace_sig is modified in driver_checked_bits, so dump here
    json.dump(trace_sig, open("%s/trace_summary.json" % s2_dir, "w"), indent=4)
    
    checked_bcs = []
    for i in checked_bcs1:
        if i not in checked_bcs:
            checked_bcs.append(i)

    if srr_info.is_asyn_func:
        checked_bcs.sort(reverse=True)
    else:
        checked_bcs.sort()
       
    color_print("Bit combinations checked by driver: \n%s" % checked_bcs)

    print('')
    return checked_bcs, trace_sig


def stage2_5(srr_info, s2_dir, term_cond0, checked_bcs, trace_sig, inv_num=1):
    # infer bits functionality by reg_acc sequence

    global model_if, model_of
    # global depth, stage_str

    #color_print("depth %d, stage: %s" % (depth, stage_str[stage]), "blue")
    print("stage2_5 inv_num = %d" % inv_num)

    #model = json.load(open(model_if))
    model = json.load(open(model_of))

    set_bits = inv_num

    # all arrays in bit_func and prereq is created with ["bit:ab,bit:cd"],
    # then converted to [(SRx_BITac, set-1, SRy_BITcd, set-1),], BIT may be -1
    # then all -1 is removed, along which clear-0 may be introduced
    '''
    bit_func = {
      "rx": [],
      "tx": [],
      "error": [], # needs to be cleared
      "unknown": [], # checked but func. unknown(e.g. USART_TXE when TX disabled)
    }
    '''
    prereq = {
      "satisfy": [], # Rx, Tx, Ready(set), Busy(clear)
      "never_satisfy": [], # Error
      "other": [], # all other combinations
    }
    prereq_sig = {
      "satisfy": [], # Rx, Tx, Ready(set), Busy(clear)
      "never_satisfy": [], # Error
      "other": [], # all other combinations
    }

    # preprocess feedbacks
    fname_l2 = [] # contains only fname that corresponds to checked bits
    reg_acc_dic = {}
    bbl_cov_dic = {}
    term_cond = {}
    reg_trace_dic = []
    for checked_bc in checked_bcs:
        # checked_bc = [[int(ab), int(cd)], [int(AB)]] -> fname = 'bit:ab+cd,bit:AB'
        fname = ""
        for checked_b in checked_bc:
            fname += "bit:%s," % '+'.join([str(x).zfill(2) for x in checked_b])
        fname = fname[:-1] # trim last ','
        fname_l2.append(fname)

        # reg_acc_dic = {fname: reg_acc_l}
        reg_acc_f = "%s/reg_acc-%s" % (s2_dir,fname)
        # reg_acc_l = [(addr, type, r/w, val, bbl_s, bbl_e)]
        reg_acc_l = re.findall((r"\((0x[0-9a-f]+), ([0-9]), ([rw]), "
            r"([0-9a-f]+)\) in BBL \((0x[0-9a-f]+), (0x[0-9a-f]+)\)"),
            open(reg_acc_f).read())

        reg_acc_dic[fname] = reg_acc_l
        
        # bbl_cov_dic = {fname: bbl_cov}
        trace_f = "%s/trace-%s" % (s2_dir,fname)
        bbl_cov_dic[fname] = cnt_bbl_cov(trace_f)

        # term_cond0 = {fname: ret_val} -> term_cond = {ret_val: [fname]}
        ret_val = term_cond0[fname]
        if ret_val not in term_cond:
            term_cond[ret_val] = [fname]
        else:
            term_cond[ret_val].append(fname)

    print("fname_l2")
    print(fname_l2)
    color_print("term_cond for checked bits: ")
    print(term_cond)
    color_print("check_bcs")
    print(checked_bcs)

    # 0x23: explore value is invalid under limit try times  
    # 0x21: explore value is valid and passed the bbl which consumes it
    # infer bit functionality per term_cond
    if set(term_cond.keys()) == set([0x23, 0x21]):
        color_print("hang + func_ret")
        if len(trace_sig["checked_bits"]) > 1:
            color_print("# of checked bits = %d > 1, code is never tested "
            "under this circumstance" % len(trace_sig["checked_bits"]), "red")

        # append bit combination that moves forward
        #prereq["satisfy"].append(term_cond[0x21][0])
        # XXX Chunlin: Here we should consider that the explore value
        # may find different path
        if srr_info.result_hang_in_while:
            #print("srr_info.result_hang_in_while")
            prereq["satisfy"] += term_cond[0x23]
        else:
            prereq["satisfy"] += term_cond[0x21]


    if set(term_cond.keys()) == set([0x23]):
          color_print("hang only")
          '''
          multiple hangs exhibit diff exec trace
          case 1: hangs at different places: one moves forward and hangs there,
          the other doesn't move forward and hangs in-place.
          We infer the condition to move forward.
          case 2: all cases move forward and hang there, 
          diff exec trace is caused by true/false branch execution. 
          We infer the condition for rx/tx, and avoid error.
          case 3: all cases don't move forward and hang in-place. 
          e.g. wait for multi-bits being set simultaneously.
          Never seen and not handled. 
          '''

          if len(trace_sig["checked_bits"]) > 1:
              color_print("# of checked bits = %d > 1, code is never tested"
                "under this circumstance" % len(trace_sig["checked_bits"]), "red")

          # tell it is case 1 or 2 by comparing last srr_site with srr_bbl_e
          # case 1: last srr_site is the same to srr_bbl_e in one case, 
          #         but different in the other
          # case 2: last srr_site are the same in both cases and differs from srr_bbl_e

          # term_srr_site = {srr_site: [fname]}
          # srr_site is represented by hex(bbl_e)
          term_srr_site = {}
          for fname in fname_l2:
              if reg_acc_dic[fname] == []:
                  continue
              last_srr_site = reg_acc_dic[fname][-1][5]
              if last_srr_site not in term_srr_site:
                  term_srr_site[last_srr_site] = [fname]
              else:
                  term_srr_site[last_srr_site].append(fname)
          color_print("term_srr_site: ")
          print(term_srr_site)

          if len(term_srr_site) == 2 and srr_info.srr_bbl_e in term_srr_site:
              # case 1, prefer bit combination that moves forward
              del term_srr_site[srr_info.srr_bbl_e]
              prereq["satisfy"].append(list(term_srr_site.values())[0][0])
              #prereq["satisfy"] += list(term_srr_site.values())[0]
              print(prereq)

          elif len(term_srr_site) == 1:
	      # Chunlin: Try to cover all fnames
              for fname in fname_l2:
                  reg_acc_l = [(ra[1], ra[2]) for ra in reg_acc_dic[fname]]
                  if ('2', 'w') in reg_acc_l:
                      # TODO other patterns to identify error bits
                      prereq["never_satisfy"].append(fname)
                  else:
                      prereq["satisfy"].append(fname)
          else:
              color_print("Unhandled cases for hang + func_ret!", "red")


    if set(term_cond.keys()) == set([0x21]):
        color_print("func_ret only")
        sr_num_i = 0
        peri_visited = []
        for base in srr_info.peri_ba:
            sr_num_i += 1
            if base in peri_visited:
                continue
            peri_visited.append(base)
            bit_func = {
              "rx": [],
              "tx": [],
              "error": [], # needs to be cleared
              "unknown": [], # checked but func. 
            }
            regs = model["model"][base]["regs"]
            for fname in fname_l2:
                color_print(fname)
                DR_r,DR_w = 0,0
                num_sr_r = 0
                index = 0
                # reg_acc_dic = {fname: [(addr, type, r/w, val, bbl_s, bbl_e)]}
                for ra in reg_acc_dic[fname]:
                    # Upon a SR_r, lifetime of value of previous SR_r ends
                    # So we don't infer bits' functionality for previous SR_r
                    # upon a new SR_r
                    index += 1
                    if ra[1] == '2' and ra[2] == 'r':
                        num_sr_r += 1 
                        if num_sr_r == sr_num_i:
                            break;
                    reg_offset = int(ra[0], 16) - int(base, 16)
                    if reg_offset < 0 or reg_offset >= cfg.peri_addr_range:
                        # reg accessed doesn't belong to the same peri 
                        # which triggered this SRR
                        continue
                    reg_idx = int(reg_offset * 8 / srr_info.sr_bits)
                    #print "ra: %s, reg_idx: %d" % (ra, reg_idx)
                    if ra[1] == '3' and regs[reg_idx]["type"] == 3:
                        # DR and is still DR at the end of current run
                        if ra[2] == 'r':
                            DR_r += 1
                        else:
                            DR_w += 1

                print("DR_r: %d, DR_w: %d" % (DR_r, DR_w))
                if DR_r > 0:
                    if fname not in bit_func["rx"]:
                        bit_func["rx"].append(fname)
                if DR_w > 0:
                    if fname not in bit_func["rx"]:
                        bit_func["tx"].append(fname)
                if (DR_r + DR_w) > 1:
                    #if fname not in bit_func["unknown"]:
                    #    bit_func["unknown"].append(fname)
                    color_print("DR_r+DR_w: %d > 1!" % (DR_r+DR_w), "red")
                print('')
	            # in some asynchronous func the reg acc are empty
		        # so we should add it to satisfy func if it is not -1
                if reg_acc_dic[fname] == []:
                    # print("reg_acc_dic is empty")
                    if fname != 'bit:-1' and fname not in bit_func["unknown"]:
                        bit_func["unknown"].append(fname)
                # just save checkbits that doesn't include bit:-1
                if srr_info.sr_num > 2 and num_sr_r > 0:
                    #if "bit-1" not in fname and fname not in bit_func["unknown"]:
                    if fname not in bit_func["unknown"]:
                        bit_func["unknown"].append(fname)

            prereq["satisfy"].extend(bit_func["rx"])
            prereq["satisfy"].extend(bit_func["tx"])
            if "Gateway" not in os.path.abspath('.'):
                prereq["satisfy"].extend(bit_func["unknown"])
            prereq["never_satisfy"].extend(bit_func["error"])

    # add all useful sr value to satisfy
    if srr_info.is_asyn_func:
        for fname in fname_l2:
            if fname not in prereq["satisfy"]:
                prereq["satisfy"].append(fname)
    # fill in other array
    for fname in fname_l2:
        if fname not in prereq["satisfy"] and \
          fname not in prereq["never_satisfy"]:
          # TODO remove dup tup when single bit is checked under single SR
          prereq["other"].append(fname)

    # both array: ['bit:ab+cd,bit:AB',] -> 
    # [[[int(ab), s/c, int(cd), s/c], [int(AB), s/c]]]
    # Convert -1 so it doesn't appear in ab/cd. 
    # If cannot convert, delete it and also signal error for satisfy
    for k,v in list(prereq.items()):
        #color_print("%s: %s" % (k,v))
        # b: bits, bc: bit_combination, str: type is string instead of int
        v1 = []
        v2 = []
        for fname in v:
            # fname = 'bit:ab+cd,bit:AB' -> bc = [[int(ab),int(cd)], [int(AB)]]
            # ab/cd can be -1
            bc = [list(map(int, b.strip("bit:").split('+'))) for b in fname.split(',')]
            # bc = [[-1,-1], [int(cd)]] -> tup = [[cb1,cb2], c, [int(cd)], s]
            tup = []
            tup2 = []
            convert_ok = True
            for i in range(0, len(bc)): #len(bc)->the num of SR need to be exploration
                b = bc[i]
                cb_dic = trace_sig
                sig_id = fname.split(",")[i].strip("bit:")
                for j in range(0, i):
                    # [int(ab), int(cd)] -> "ab+cd"
                    cb_dic_k = '+'.join([str(x).zfill(2) for x in tup[j*2]])
                    cb_dic = cb_dic[cb_dic_k]
                if b == [-1]*set_bits and srr_info.is_asyn_func is False:
                    # figure out what bits are checked for current SR
                    # under bit combinations of previous SR
                    if "checked_bits" in cb_dic:
                        if len(cb_dic["checked_bits"]) == 1:
                            # single checked bit
                            tup.append(cb_dic["checked_bits"][0])
                            tup.append(0)
                            tup2.append(cb_dic[sig_id]["sig"])
                        elif len(cb_dic["checked_bits"]) == 0:
                            # TODO detect no-checked bit SR under multi-SR
                            tup.append([-1]*set_bits)
                            tup.append(0)
                            tup2.append(cb_dic[sig_id]["sig"])
                        else:
                            # multiple checked bits
                            # convert_ok = False
                            if k == "other":
                              # For other, delete if cannot convert
                              break
                            # XXX now we just chose the second, but we should to polish it
                            tup.append(cb_dic["checked_bits"][1])
                            tup.append(0)
                            tup2.append(cb_dic[sig_id]["sig"])
                            # For satisfy/never_satisfy, signal err if cannot convert
                            color_print("-1 appears when multiple bits are checked, "
                              "we cannot handle it currently!", "red")
                    else:
                       tup.append([-1]*set_bits)
                       tup.append(0)
                       tup2.append(cb_dic[sig_id]["sig"])
                      
                else:
                    # not -1, don't have to do conversion
                    tup.append(b)
                    tup.append(1)
                    tup2.append(cb_dic[sig_id]["sig"])
                 
            if convert_ok:
              v1.append(tup)
              v2.append(tup2)
            # end of "for i in range(0, len(bc)):"

        prereq[k] = v1
        prereq_sig[k] = v2
        # end of "for fname in v:"

    for k,v in list(prereq.items()):
        lindex = []
        for i in range(0, len(v)):
            if len(prereq[k][i]) != 2 * srr_info.sr_num:
                lindex.append(i)
        for i in reversed(lindex):
            del prereq[k][i]
            del prereq_sig[k][i]
    # end of "for k,v in prereq.items():"
    #color_print("prereq: %s" % prereq)
    #color_print("prereq_sig: %s" % prereq_sig)
    return prereq, prereq_sig



def stage3(prereq_list, sig_list, srr_info, inv_num=1):
    # erase duplicate prereq item and dump then into file

    global model_if, model_of
    print("stage3")
    stage = 3.0
    model_if = model_of
    model_of = "model-depth:%s,stage:%.1f.json" % (depth,stage)
    model = json.load(open(model_if))
    prereq = {
      "satisfy": [], # Rx, Tx, Ready(set), Busy(clear)
      "never_satisfy": [], # Error
      "other": [], # all other combinations
    }
    sat_sig = []
    nsat_sig = []
    oth_sig = []
	# Merge prereq_list 
    for i in range(0, len(prereq_list)):
        sat = prereq_list[i]["satisfy"]
        nsat = prereq_list[i]["never_satisfy"]
        oth = prereq_list[i]["other"]
        ssig = sig_list[i]["satisfy"]
        nsig = sig_list[i]["never_satisfy"]
        osig = sig_list[i]["other"]
        for ii in range(0, len(sat)):
            if ssig[ii] not in sat_sig:
                prereq["satisfy"].append(sat[ii])
                sat_sig.append(ssig[ii])
        for ii in range(0, len(nsat)):
            if nsig[ii] not in nsat_sig:
                prereq["never_satisfy"].append(nsat[ii])
                nsat_sig.append(nsig[ii])
        for ii in range(0, len(oth)):
            if osig[ii] not in oth_sig:
                prereq["other"].append(oth[ii])
                oth_sig.append(osig[ii])

    # stat all peri
    base_list = []
    srr_site_sr_num = {}
    srr_site_sr_idx = {}
    t = 0
    for base in srr_info.peri_ba:
        if base not in base_list:
            base_list.append(base)
            srr_site_sr_num[base] = 1
            srr_site_sr_idx[base] = []
        else:
            srr_site_sr_num[base] += 1
        srr_site_sr_idx[base].append(srr_info.sr_idx[t])
	# modify hang_in_while flag
        model["model"][base]["regs"][srr_info.sr_idx[t]]["result_hang_in_while"] = 0
        t += 1

    # dump events into json
    for base in base_list:
        evts = model["model"][base]["events"]
        CR_val1 = srr_info.CR_val[srr_info.peri_ba.index(base)]
        if CR_val1 not in evts:
            evts[CR_val1] = {}
        conf = evts[CR_val1]

        if srr_info.srr_bbl_e in conf:
            # TODO move this warning to the end of stage 1
            color_print("We have done PI on this BBL before!", "yellow")
        else:
            conf[srr_info.srr_bbl_e] = {}
        srr_site = conf[srr_info.srr_bbl_e]

        if srr_info.CR_SR_r_idx:
            # if > 0 (checked at stage2_5), CR_SR (at most 1) requires SMR
            srr_site["CR_SR_r_idx"] = srr_info.CR_SR_r_idx

        abnormal_flag = False
        for k,v in list(prereq.items()):
            v1 = []
            for i in range(0, len(v)):
                v2 = []
                for ii in range(0, srr_info.sr_num):
                    if srr_info.peri_ba[ii] == base:
                        v2.append(v[i][ii * 2])
                        v2.append(v[i][ii * 2 + 1])
                v1.append(v2)

            if k in srr_site:
                ll = srr_site_sr_num[base] - srr_site["sr_num"] 
                if ll > 0:
                    for l in range(0, len(srr_site[k])):
                        srr_site[k][l] += [[-1] * srr_site["set_bits"], 0] * ll
                # ll == 0 -> need not handle
                # ll < 0 -> not exist in augment 
                #srr_site[k] += v1
                for vi in v1:
                    if vi not in srr_site[k]:
                        srr_site[k].append(vi);
                        print(vi)
                    else:
                        # repeat model at a srr site, maybe hang in while
                        abnormal_flag = True
            else:
                srr_site[k] = v1

        if abnormal_flag is True:
            if srr_info.cur_excp_num != 15:
                print("abnormal_flag=True")
                for interrupt in model["interrupts"]:
                    if interrupt["excp_num"] == srr_info.cur_excp_num:
                        interrupt["result_hang"] = 1
                        break;
        srr_site["sr_num"] = srr_site_sr_num[base]
        srr_site["sr_idx"] = srr_site_sr_idx[base]
        srr_site["set_bits"] = inv_num
        if srr_info.result_hang_in_while:
            #print("detect result hang")
            srr_site["is_result_hang"] = srr_info.result_hang_in_while

        if args.eval:
            srr_site["srr_func"] = srr_info.srr_func
            srr_site["bbl_cnt"] = srr_info.srr_bbl_cnt

    json.dump(model, open(model_of, "w"), indent=4)

    print('')
    return



if __name__ == "__main__":
    start_time = time.time()
    run_from_afl = "0"
    parser = argparse.ArgumentParser(description="Model Extraction Tool")
    # args must be processed before chdir to run_num
    parser.add_argument("--model-if", dest="model_if", default=None, 
        help="model input file")
    parser.add_argument("-c", "--config", dest="config", 
        default="%s/fuzz.cfg" % os.path.dirname(sys.argv[0]),
        help="configuration file. Default: fuzz.cfg")
    parser.add_argument("-g", "--ground-truth", dest="gt", default=None,
        help="ground truth file in csv format")
    # args processed after chdir to run_num
    parser.add_argument("--run-num", dest="run_num", default="1", 
        help="number of run")
    parser.add_argument("-f", "--print-to-file", dest="print_to_file", 
        action='store_true', help="redirect stdout to file named stdout")

    # evaluation
    parser.add_argument("-e", "--evaluation", dest="eval", 
        action='store_true', help="switch to turn on evaluation only operations")

    fs = parser.add_argument_group("arguments for run from forkserver")
    #fs.add_argument("--run-from-forkserver", dest="run_from_fs", 
    #    action="store_true", help="if is invoked from forkserver during fuzzing")
    fs.add_argument("--run-from-forkserver", dest="run_from_fs", default="0",help="if is invoked from forkserver during fuzzing")
    fs.add_argument("--afl-file", dest="afl_file", default=None, 
        help="fuzzer generated input file for DR read")
    args = parser.parse_args()

    if args.model_if:
        args.model_if = os.path.abspath(args.model_if)

    cfg = read_config(args.config)

    if args.gt:
        args.gt = os.path.abspath(args.gt)
        try:
          csv.Sniffer().sniff(open(args.gt, 'rb').read(1024))
        except:
          sys.exit("ground truth file %s is not a valid csv file" % args.gt)

    if not os.path.exists(args.run_num):
        os.makedirs(args.run_num)
    color_print("Change working dir to: %s/" % args.run_num)
    os.chdir(args.run_num)
    
    if args.print_to_file:
        color_print("Redirect stdout to file named stdout")
        sys.stdout = open("stdout", 'w')
        sys.stderr = open("stderr", 'w')
        shutil.copyfile(cfg.img, "firmware.elf")

    if args.run_from_fs != "0":
        # log invocation of me alg
        logging.basicConfig(filename=cfg.log_f, level=logging.INFO, 
          format='[%(asctime)s] %(message)s', datefmt='%m/%d/%Y %I:%M:%S %p')
        model = json.load(open(args.model_if))
        logging.info("run_num %s, access_to_unmodeled_peri: %s" % 
          (args.run_num, model["access_to_unmodeled_peri"]))
        # copy aflFile
        shutil.copyfile(args.afl_file, "aflFile")

    #end addr of end
    eaddr = get_main_end_addr()

    signal.signal(signal.SIGTERM, sig_handler)
    atexit.register(exit_callback)

    depth = 0

    stage_str = {
        0: "INVALID", 
        # the following line must be consistent w/ qemu's def
        1: "SR_R_ID", 2: "SR_R_EXPLORE", 3: "FUZZING",
        # rerun qemu when stage 1 is terminated by SR_cat_by_fixup
        1.1: "rerun SR_R_ID, since it is terminated by SR_cat_by_fixup",
        # below is py only
        1.4: "identify and handle registers adjusted to/from CR/SR",
        1.5: "collect info for SR read site",
        1.9: "prepare input for SR_R_EXPLORE",
        2.2: "identify and handle register category changes during SR_R_EXPLORE",
        2.4: "identify bits checked by driver at this srr",
        2.5: "infer functionality of each checked bit",
    }

	# add qemu.log just for test
    cmd_base = [cfg.qemu_bin, "-verbose", "-verbose", "-d", cfg.qemu_log, "-nographic", "-board", cfg.board, "-mcu", cfg.mcu, "-image", cfg.img, "-main-eaddr", eaddr, "-len-seeds", cfg.len_seeds, "-len-round", cfg.len_round, "-hang-mode", cfg.hang_mode]

    if args.run_from_fs == "2":
        cmd_base.append("-run-from-afl")
    # bbl_cov = {(hex_str(bbl_s), hex_str(bbl_e)): cnt}
    bbl_cov = {} # reset when ME restart due to e.g. cr_ins

    # rc_adjusted_sum = {"depth:%s,stage:%.1f": rc_adjusted}
    rc_adjusted_sum = {}

    last_peri_model = args.model_if
    while True:
        depth += 1

        ret_val = stage1()
        if ret_val == 0x19: #SR_cat_by_fixup=True, DR->SR consec_read>threshold
            stage1(redo=True)

        cr_ins_happen = stage1_4()
        if cr_ins_happen:
            bbl_cov = {} # reset when ME restart due to e.g. cr_ins
            continue

        # do assignment here rather than after stage 1 to guarantee adjusted SMR
        last_peri_model = model_of

        if ret_val == 0x30:
            color_print("QEMU hasn't seen unmodeled SR_r site for a while, "
              "terminate model extraction alg!\nPossible reasons: hang caused "
              "by an error or we have extracted all possible model.", "blue")
            sys.exit()


        srr_info = stage1_5()
        
        inv_num = 1
        prereq_list = []
        sig_list = []
        # Explore more than three bits will waste too time, just close it
        '''
        max_bit = 4
        for inv_num in range(1, max_bit):
            (sr_dir, fname_l) = stage1_9(srr_info, inv_num)
            (s2_dir, term_cond0) = stage2(srr_info, sr_dir, fname_l, inv_num, 1)
            stage2_2(srr_info, s2_dir, fname_l, inv_num)
            (checked_bcs, trace_sig) = stage2_4(srr_info, s2_dir, inv_num)
            (prereqi, sigi)= stage2_5(srr_info, s2_dir, term_cond0, checked_bcs, trace_sig, inv_num)
            prereq_list.append(prereqi)
            sig_list.append(sigi)
        print(prereq_list)
        stage3(prereq_list, sig_list, srr_info, inv_num)
        last_peri_model = model_of
        color_print("depth %d done!\n" % depth, "blue")
        ''' 
        (sr_dir, fname_l) = stage1_9(srr_info)
        (s2_dir, term_cond0, sr_result_hang) = stage2(srr_info, sr_dir, fname_l)
        stage2_2(srr_info, s2_dir, fname_l)
        check_mode = False
        if set(term_cond0.values()) == set([0x21]):
            check_mode = True
        (checked_bcs, trace_sig) = stage2_4(srr_info, s2_dir, inv_num, sr_result_hang, check_mode)
        if checked_bcs == [[[-1]]]: # TODO support multi SR
          color_print("No bits are checked! Run stage 2 again with "
            "workers terminates after TWO func_ret or 'timeout'", "yellow")

          (s2_dir, term_cond0, sr_result_hang) = stage2(srr_info, sr_dir, fname_l, inv_num, 1)
          stage2_2(srr_info, s2_dir, fname_l, inv_num)
          (checked_bcs, trace_sig) = stage2_4(srr_info, s2_dir, inv_num, sr_result_hang, check_mode)

          if checked_bcs == [[[-1]]]:
            color_print("Still no bits are checked! Run stage 2 again with "
              "inputs setting TWO bits, and workers terminates after ONE "
              "func_ret", "yellow")
            inv_num = 2

            (sr_dir, fname_l) = stage1_9(srr_info, inv_num)
            (s2_dir, term_cond0, sr_result_hang) = stage2(srr_info, sr_dir, fname_l, inv_num)
            stage2_2(srr_info, s2_dir, fname_l, inv_num)
            (checked_bcs, trace_sig) = stage2_4(srr_info, s2_dir, inv_num, sr_result_hang, check_mode)

            if checked_bcs == [[[-1]*2]]:
              color_print("Still no bits are checked! It may not be a SR!", 
                "yellow")
              indexi = 0
              sr_locked_flag = False
              for base in srr_info.peri_ba:
                model = json.load(open(model_of))
                peri = model["model"][base]
                reg = peri["regs"][srr_info.sr_idx[indexi]] 
                if "sr_locked" in reg and not reg["sr_locked"]:
                  sr_locked_flag = True
                  color_print("SR is not locked, adjust it to DR", "yellow")
                  reg["type"] = 3
                  # handle sr_del
                  handle_sr_cr_del(peri["events"], 
                    {"cr_del":[], "sr_del":[srr_info.sr_idx[indexi]]})
                  json.dump(model, open(model_of, "w"), indent=4)
                  color_print("depth %d done!\n" % depth, "blue")
                else:
                  color_print("SR is locked! Don't adjust it to DR", "yellow")
                indexi += 1
              if sr_locked_flag is True:
                continue


        (prereqi, sigi) = stage2_5(srr_info, s2_dir, term_cond0, checked_bcs, trace_sig, inv_num)
        prereq_list.append(prereqi)
        sig_list.append(sigi)
        stage3(prereq_list, sig_list, srr_info, inv_num)
        last_peri_model = model_of
        color_print("depth %d done!\n" % depth, "blue")
        

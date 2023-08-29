#! /usr/bin/env python3
import os, subprocess

def get_main_end_addr(fpath):
#def get_main_end_addr():
    objdump_path = "/usr/bin/arm-none-eabi-objdump"
    #fpath = "/home/chunlin/TSIS/dir_analyze/DICE-advance/DICE-Evaluation/ARM/Fuzzing/Firmware/Binaries/HeatGun.elf"
    path_nm = os.path.dirname(objdump_path) + "/arm-none-eabi-nm"
    cmd1 = path_nm + " -n " + fpath + " | grep -w '\w\smain' | " + "awk '{print $1}'"
    cmd2 = path_nm + " -n " + fpath + " | grep -w -A1 '\w\smain' | " + "awk '{getline; print $1}'"
    start_addr = "0x" + os.popen(cmd1).read().replace('\n', '')
    stop_addr = "0x" + os.popen(cmd2).read().replace('\n', '')
    print(start_addr)
    print(stop_addr)
    if start_addr is "0x" and stop_addr is "0x":
        cmd1 = path_nm + " -n " + fpath + " | grep '_main' | " + "awk '{print $1}'"
        cmd2 = path_nm + " -n " + fpath + " | grep -A1 '_main' | " + "awk '{getline; print $1}'"
        start_addr = "0x" + os.popen(cmd1).read().replace('\n', '')
        stop_addr = "0x" + os.popen(cmd2).read().replace('\n', '')
    
    cmd3 = objdump_path + " -d " + fpath + " --start-address=" + start_addr + " --stop-address=" + stop_addr 
    objdump = os.popen(cmd3).read()
    for l in objdump.split('\n')[::-1]:
        print(l)

    for l in objdump.split('\n')[::-1]:
        if "nop" not in l and ".word" not in l and l != "" and "..." not in l:
            return l.split(':')[0].strip(' ')
            #print(l)
            break
    #print('')


if __name__ == "__main__":
    #fdir = "/home/chunlin/TSIS/dir_analyze/DICE-advance/DICE-Evaluation/ARM/Fuzzing/Firmware/Binaries"
    fdir = "/home/chunlin/TSIS/dir_analyze/DICE-advance/DICE-Evaluation/ARM/Fuzzing/Firmware/Binaries-No-Ins"
    '''
    for root, dirs, files in os.walk(fdir):
        print(root)
        print(dirs)
        print(files)
    '''
    '''
    for name in os.listdir(fdir):
        if "strip" in  name:
            continue
        print(name)
        print(get_main_end_addr(fdir + "/" + name))
        print('')
    #get_main_end_addr()
    '''
    print(get_main_end_addr(fdir + "/" + "Modbus-Redzones.elf"))


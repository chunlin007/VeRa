#! /usr/bin/env python3
import os, sys, struct

def get_func_decompiler(objdump, img, funcname):
    nm = os.path.dirname(objdump) + "/arm-none-eabi-nm"
    cmd1 = nm + " -n " + img + " | grep -w '\w\s" + funcname + "' | " + "awk '{print $1}'"
    cmd2 = nm + " -n " + img + " | grep -w -A1 '\w\s" + funcname + "' | " + "awk '{getline; print $1}'"
    addr1 = "0x" + os.popen(cmd1).read().replace('\n', '')
    addr2 = "0x" + os.popen(cmd2).read().replace('\n', '')
    if addr1 == "0x" and addr2 == "0x":
        cmd1 = nm + " -n " + img + " | grep '" + funcname + "' | " + "awk '{print $1}'"
        cmd2 = nm + " -n " + img + " | grep -A1 '" + funcname + "' | " + "awk '{getline; print $1}'"
        addr1 = "0x" + os.popen(cmd1).read().replace('\n', '')
        addr2 = "0x" + os.popen(cmd2).read().replace('\n', '')

    cmd3 = objdump + " -d " + img + " --start-address=" + addr1 + " --stop-address=" + addr2
    cmd3 += " | grep -e tst | awk -F '; ' '{print $2}' | sort | uniq"
    return os.popen(cmd3).read().split('\n')

def sr_val_parser(val_list):
    for val in val_list: 
       _val = 0 if val == '' else int(val, 16)
       print("\n%x" % _val)
       bytecode = struct.pack(">I", _val)
       print(bytecode)
       for i in range(0, 32):
           print("%d"%(_val % 2), end='')
           _val /= 2
      


if __name__ == "__main__":
    print("try to obtain sr like value")
    objdump = "/home/chunlin/Downloads/gcc-arm-none-eabi-10/bin/arm-none-eabi-objdump"
    img = "/tmp/Gateway.elf"
    funcname = "HAL_I2C_EV_IRQHandler"
    val_list = get_func_decompiler(objdump, img, funcname)
    sr_val_parser(val_list)

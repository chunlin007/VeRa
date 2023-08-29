#! /usr/bin/env python3

import time, os

# firmware hang in while(1)
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

# firmware hang in handle same operations in loop, such as blk led
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


if __name__  == "__main__": 
    t1 = time.time()
    ret = sr_result_hang_func("./trace-test00", "LED_Blinking")
    print(ret)
    ret = sr_result_hang_func("./trace-test01", "DMA1_Channel1_IRQHandler")
    print(ret)
    ret = sr_result_hang_func("./trace-test02", "DMA1_Channel1_IRQHandler")
    print(ret)
    ret = sr_result_hang_func("./trace-test03", "ADC_DMAConvCplt")
    print(ret)
    print(time.time() - t1)

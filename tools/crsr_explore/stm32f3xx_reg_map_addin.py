#! /usr/bin/env     python3

'''
    To generate status and ctrl value refering to reg status map
    Author: Chunlina Wang
    E-mail: chunlin_wang01@163.com
    Date: 2022-09-23
'''
import io, sys, struct, random, time, os
from struct import *
from random import *

basic_mem_map = [

    0x00000001, 0x00000002, 0x00000004, 0x00000008,
    0x00000010, 0x00000020, 0x00000040, 0x00000080,
    0x00000100, 0x00000200, 0x00000400, 0x00000800,
    0x00001000, 0x00002000, 0x00004000, 0x00008000,
    0x00010000, 0x00020000, 0x00040000, 0x00080000,
    0x00100000, 0x00200000, 0x00400000, 0x00800000,
    0x01000000, 0x02000000, 0x04000000, 0x08000000,
    0x10000000, 0x20000000, 0x40000000, 0x80000000

]

'''
    Combination of register mask typeI
    @mask: the origin mask queue need to deal
    @ncomb: the num of mask which need to combine
        ncomb = num: combine nums' mask value 
'''
def comb_reg_mask1(mask, ncomb):
    #print("comb_reg_mask")
    len_mask =len(mask)
    if 2 == ncomb:
        id1 = randrange(len_mask)
        id2 = randrange(len_mask)
        return mask[id1] | mask[id2]
    elif 3 == ncomb:
        id1 = randrange(len_mask) 
        id2 = randrange(len_mask) 
        id3 = randrange(len_mask) 
        return mask[id1] | mask[id2] | mask[id3]
    else:
        num =  randrange(len_mask) + 1
        res = 0
        for i in range(0, num + 1):
            id1 = randrange(len_mask) 
            res |= mask[id1]
        return res

'''
    Combination of register mask typeII
    @ncomb: the num of mask which need to combine
        ncomb = num: combine nums' mask value 
'''
def comb_reg_mask2(ncomb):
    #print("comb_reg_mask")
    ncomb = ncomb if ncomb > 0 else 1
    sr_bits = 32
    arr = []
    _mask= 0
    _len = 32
    sr_dir = "./"
    ncomb = randrange(sr_bits)
    for _index in range(0, sr_bits):
        _fname = "bit:%02d"%_index
        for i in range(0, ncomb):
            _id = randrange(_len)
            _mask |= basic_mem_map[_id]
        '''
        with open("%s/%s" % (sr_dir, _fname), "wb") as f:
            f.write(struct.pack('>I', _mask))
        '''
        arr.append(_fname.encode())

    arr.append(struct.pack('>I', 0))
    return arr

'''
    Generate status value according to addr
    @addr: the access address we need to judge
    @level: the level of genertating status register value
            just return mask when level == 0/1
            use combianation when level > 0
'''
def generate_reg_value1(addr, level = 0):
    
    base = addr & 0xffff0000  
    off1 = addr & 0x0000ff00
    off2 = addr & 0x000000ff
    arr = [] # store filename 
    if 0 == level or 1 == level:
        for mask in map_stm32f303xd[base][off1][off2]:
            print(struct.pack('>I', mask))
    else:
        _len = len(map_stm32f303xd[base][off1][off2])
        for i in range(0, _len):
            mask = comb_reg_mask(map_stm32f303xd[base][off1][off2], level)
            print(struct.pack('>I', mask) )
     #return arr

# main
if __name__ == "__main__":

    print("Gennerate a new value for status register")
    #print(map_stm32f303xd[0x40000000][0x000][0x00][0])
    '''
    pint("level == 0/1")
    generate_reg_value(0x40000000, 0)
    print("level == 2")
    generate_reg_value(0x40000000, 2)
    print("level == 3")
    generate_reg_value(0x40000000, 3)
    index = 1
    fname = "value%d"%index
    print(fname)
    '''
    #print(comb_reg_mask2(32))
    one_str = []
    for i in range(0, 32):
        sr_i = (struct.pack('>I', 1<<i), ("bit:%02d,"%i).encode())
        one_str.append(sr_i)
    one_str.append((struct.pack('>I', 0), ("bit:%02d,"%i).encode()))
    print(one_str)
    #os.environ['NEED_CHANGE_STRATEGY'] = "1"
    need_change_strategy = os.environ.get('NEED_CHANGE_STRATEGY', 0) 
    #if need_change_cate != 0:
    print(need_change_strategy)
    if need_change_strategy != 0:
        del(os.environ['NEED_CHANGE_STRATEGY'])
    need_change_strategy = os.environ.get('NEED_CHANGE_STRATEGY', 0) 
    print("%d"%int(need_change_strategy))
    a = 5
    res = 1 if a == 0 or a == 1 else 3
    print(res)





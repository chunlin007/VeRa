#! /usr/bin/env python3
import struct
from struct import *

#----------------origin-------------------------#
def one_sr_input_gen(sr_bits, one_cnt, one_name, prev_set_bit, set_bits):

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
#----------------origin-------------------------#


#----------------modify-------------------------#
def one_sr_input_gen1(sr_bits, one_cnt, one_name, prev_set_bit, set_bits):

    one_sr = []
    _base = 0
    for _b in range(set_bits):
        _base = _base | 1 << _b
    for _off in range(0, sr_bits - set_bits + 1):
        _val = _base << _off
        _fname = "bit:%02d"%_off
        for _bit in range(_off + 1, _off + set_bits):
            _fname = _fname + "+%02d"%_bit
        _fname = _fname + ","
        one_sr.append((struct.pack(">I", _val), _fname.encode())) 
    return one_sr # [('\xXX\xXX\xXX\xXX', "bit:01+02,")]


def input_f_writer1(sr_bits, sr_num, sr_dir, content, fname, set_bits):

    arr = []
    if sr_num >= 1:
        # gen input for 1 SR setting @set_bits bits, and add a baseline
        one_sr = one_sr_input_gen1(sr_bits, 0, b"", sr_bits, set_bits)
        one_sr.append((struct.pack(">I",0), ("bit:%s," % ("-1+"*set_bits)[:-1]).encode()))
        for (one_cnt, one_name) in one_sr:
            arr += input_f_writer1(sr_bits, sr_num-1, sr_dir,
                content+one_cnt, fname+one_name, set_bits)
    else:
        fname = fname[:-1] # trim last ','
        with open("%s/%s" % (sr_dir, fname.decode()), "wb") as f:
            f.write(content)
        arr.append(fname)
    return arr # flat array of filenames

#----------------modify-------------------------#


# [ Single use ]
# @sr_bits: the length of register
# @set_bits: number of bits set in each input
def input_f_writer2(sr_bits, sr_num, sr_dir, content, fname, set_bits):
    '''
    print("-----input_f_writer2-begin------")
    print(sr_bits)
    print(sr_num)
    print(sr_dir)
    print(content)
    print(fname)
    print(set_bits)
    print("-----input_f_writer2-end------\n")
    '''
    arr = []
    _base = 0
    for _b in range(set_bits):
        _base = _base | 1 << _b
    for _off in range(0, sr_bits - set_bits + 1):
        _val = _base << _off
        _fname = "bit:%02d"%_off
        for _bit in range(_off + 1, _off + set_bits):
            _fname = _fname + "+%02d"%_bit
        with open("%s/%s" % (sr_dir, _fname), "wb") as f:
            #print("fname=%s,_val=%d"%(_fname, _val))
            #print(struct.pack(">I", _val))
            f.write(struct.pack(">I", _val))
        arr.append(_fname)

    return arr # flat array of filenames



if __name__ == "__main__":
    print("multi-status")
    #--------Test input_f_writer -----------------
    #input_f_writer2(32, 0, "/tmp/sr_inputs", "", "name", 2)
    #print("--------------")
    #input_f_writer2(32, 5, "/tmp/sr_inputs", "", "name", 5)
    #input_f_writer(32, 2, "/tmp/sr_inputs", b'', b"", 1)
    input_f_writer1(32, 2, "/tmp/sr_inputs", b'', b"", 1)

    #--------Test input_f_writer -----------------
    #one_sr = []
    #one_sr = one_sr_input_gen(32, 0, b"", 32, 2)
    #print(one_sr)   
    #print("-------------------------------------")
    #one_sr = one_sr_input_gen1(32, 0, b"", 32, 2)
    #print(one_sr)   


'''
for name in `ls /tmp/sr_inputs`; do num=`cat "/tmp/sr_inputs/"$name | hexdump -C | awk -F' ' '{print $2 $3 $4 $5}'`; echo $num; rax2 "Bx"$num ;done
'''

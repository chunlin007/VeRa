#! /usr/bin/env python3
import json, os, time, subprocess


if __name__ == "__main__":

	'''
	events = {
		"11:0x11,22:0x22": {
			"0x80": {
				"set_bits": 2
			}, 
			"0x81": {
				"set_bits": 2
			}
		},
		"33:0x33,44:0x44": {
			"0x80": {
				"set_bits": 2
			}, 
			"0x81": {
				"set_bits": 2
			}
		},
	}
	for config in events:
		print(config)
		print(events[config])
	print(list(events.items()))
	for k,v in list(events.items()):
		print(k)
		print(v)
	'''	
    #fpath = "/tmp/vshared.json"
    #dic1 = {"need_change": 0}
    #print("dic1 = ", end='')
    #print(dic1)
    #json.dump(dic1, open(fpath, "w"), sort_keys=True, indent=4)
    #subprocess.call("./test")
    #dic2 = json.load(open(fpath, "r"))
    #print("dic2 = ", end='')
    #print(dic2)
	fdir = "/root/FuzzBase2/GPS-Receiver/1.0"
	fpath = "/root/FuzzBase2/GPS-Receiver/1.0/0/bbl_cov"
	dic3 = json.load(open(fpath, "r"))
	#print(dic3)
	bbl_cov = {}
	for k,v in list(dic3["bbl_cov"].items()):
		#print(k, end=' ')
		#print(v)
		bbl_cov[k] = v;
	print(bbl_cov)

	'''
    regs = [
                {
                    "type": 0,
                    "read": 1,
                    "write": 1,
                    "evals": [1, 2]
                },
                {
                    "type": 3,
                    "read": 0,
                    "write": 1,
                    "evals": [1, 2]
                },
                {
                    "type": 2,
                    "read": 1,
                    "write": 1,
                    "evals": [1, 2]
                },
                {
                    "type": 1,
                    "read": 0,
                    "write": 1,
                    "evals": [1, 2]
                }
           ]
    for reg in regs:
       print(reg)
       if reg["type"] == 3:
           del reg["evals"]

    
    print("after adjust")

    index = 0
    for index in range(len(regs)):
        print(regs[index])

    reg= regs[3]
    reg["evals"] = [3, 2, 2]
    print(regs[3])
    num1 = [int("17", 16), int("12", 16)]
    print(num1)
    '''


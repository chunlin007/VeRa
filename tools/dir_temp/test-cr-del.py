#! /usr/bin/env python3
import json, os, time, subprocess, sys


if __name__ == "__main__":

	prereq = {
		"0:0x2d,1:0x0,2:0x0": {
			 "0x8008998": {
                 "never_satisfy": [],
                 "other": [
                     [
                         [ 1 ], 0, 
                         [ 2 ], 0, 
						 [ 3 ], 1
                     ]
                 ],
                 "satisfy": [
                     [
                         [ 1 ], 1,
                         [ 2 ], 1,
						 [ 3 ], 1
                     ],
                     [
                         [ 1 ], 1,
                         [ 2 ], 1,
						 [ 3 ], 1
                     ]
				 ],
                 "set_bits": 1,
                 "sr_idx": [
                     7, 8, 9
                 ],
                 "sr_num": 3
             }
		}
	}
	rca = {
		"sr_del" : [ 7,8,9 ]
	}
	prereq_upd = {}
	for peri_cfg, v in list(prereq.items()):
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
			prereq_upd[peri_cfg] = v_upd

	print("------------Before-------------")
	json.dump(prereq, sys.stdout, indent = 4)
	print("------------After-------------")
	json.dump(prereq_upd, sys.stdout, indent = 4)

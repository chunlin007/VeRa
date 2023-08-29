#! /usr/bin/env python3
import json, os, time, subprocess, sys


if __name__ == "__main__":

	events = {
        "0:0x2d,1:0x0,2:0x0": {
             "0x8008998": {
                 "never_satisfy": [],
                 "other": [
                     [
                         [ 1 ], 0,
                         [ 3 ], 1
                     ]
                 ],
                 "satisfy": [
                     [
                         [ 1 ], 1,
                         [ 2 ], 1
                     ],
                     [
                         [ 1 ], 1,
                         [ 2 ], 1
                     ]
                 ],
                 "set_bits": 1,
                 "sr_idx": [
                     1, 2
                 ],
                 "sr_num": 2
             }
        }
    }
	prereq = {
        "never_satisfy": [],
        "other": [
            [
                [ 1 ], 0, 
		   	    [ 2 ], 1
            ]
        ],
        "satisfy": [
            [
                [ 1 ], 1,
		   	    [ 2 ], 1
            ],
            [
                [ 1 ], 1,
		   	    [ 2 ], 1
            ]
		],
	}
	json.dump(events, sys.stdout, indent = 4)
	print("-----------------------")
	CR_val = "0:0x2d,1:0x0,2:0x0"
	srr_bbl_e = "0x8008998"
	prereq_srr_idx = [ 1, 2 ]
	conf = events[CR_val]
	srr_site = conf[srr_bbl_e]
	srr_idx = srr_site["sr_idx"]
	set_bits = srr_site["set_bits"]
	for k,v in list(prereq.items()):
		if k in srr_site:
			ll = len(prereq_srr_idx) > srr_site["sr_num"]
			if ll > 0:
				for id1 in range(0, len(srr_site[k])):
					# add [-1], 0 to empty bit
					srr_site[k][id1] += [ [-1] * set_bits, 0 ] * ll
					#for l in range(0, ll):
						#srr_site[k][id1].append[ -1 ] * set_bits)
						#srr_site[k][id1].append(0)
			if ll < 0:
				print("Not exist!")
			srr_site[k] += v
		else:
			srr_site[k] = v
	json.dump(events, sys.stdout, indent = 4)

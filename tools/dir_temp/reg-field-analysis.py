#! /usr/bin/env python3
import json, os, time, subprocess, sys, string


if __name__ == "__main__":

	#fpath = "/root/FuzzBase2/Stepper-Motor/1.0/0.input.data.8/peripheral_model.json"
	#fpath = "/root/FuzzBase2/Modbus/1.0/1/peripheral_model.json"
	fpath = "/root/FuzzBase2/MIDI-Synthesizer/1.0/0/peripheral_model.json"
	model = json.load(open(fpath, "r"))
	#json.dump(model, sys.stdout, sort_keys=True, indent=4)
	peri_list = model["model"]
	for base, peri in list(peri_list.items()):
		print("")
		print("------------%s-----------" % base)
		regs = peri["regs"]
		print("--------------regs---------------")
		idx = 0
		for regi in regs:
			reg_addr = hex(int(base, 16) + idx * 4)
			idx += 1
			if regi["type"] != 3 and regi["type"] != 0:
				evals_list = []
				num1 = 0
				for evals in regi["evals"]:
					if evals["val"] != "0x0":
						val1 = int(evals["val"], 16)
						evals_list.append(val1)
						num1 = num1 | val1
				if evals_list != []:
					print(reg_addr)
					for val2 in evals_list:
						print(bin(val2)[2:].zfill(32))
					print("--------valid field-----------")
					print(bin(num1)[2:].zfill(32))
				print("")
				
		#break
		
		
	

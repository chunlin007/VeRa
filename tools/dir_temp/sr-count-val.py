#! /usr/bin/env python3
import json, os, time, subprocess, sys, string


if __name__ == "__main__":

    fpath = sys.argv[1]
    if fpath == "" or os.path.exists(fpath) is False:
        fpath = "/root/FuzzBase2/Stepper-Motor/1.0/3/peripheral_model.json"
    #fpath = "/root/FuzzBase2/Modbus/1.0/1/peripheral_model.json"
    #fpath = "/root/FuzzBase2/MIDI-Synthesizer/1.0/0/peripheral_model.json"
    model = json.load(open(fpath, "r"))
    #json.dump(model, sys.stdout, sort_keys=True, indent=4)
    peri_list = model["model"]
    num_sat = 0
    num_oth = 0
    for base, peri in list(peri_list.items()):
        #print("")
        #print("------------%s-----------" % base)
        #print("--------------regs---------------")
        event = model["model"][base]["events"]
        for cr,eventi in list(event.items()):
            for sr,evei in list(eventi.items()):
                num_sat += len(evei["satisfy"])
                num_oth += len(evei["other"])
    print("satisfy=%d, other=%d"%(num_sat, num_oth))

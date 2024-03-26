#!/usr/bin/env python3
'''
   DICE - script to execute a model instantiation with P2IM supporting DMA
   ------------------------------------------------------

   Copyright (C) 2018-2020 RiS3 Lab

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at:

     http://www.apache.org/licenses/LICENSE-2.0

'''

import sys, shutil, subprocess, os
from os import getcwd

# uncoment the version of QEMU that you want to use: precompiled or compiled locally 

# DICE QEMU precompiled binary
#qemu_path = os.path.abspath("../../../DICE-precompiled/ARM_bin/qemu-system-gnuarmeclipse")

# DICE QEMU compiled locally
qemu_path =  os.path.abspath("../../../p2im/qemu/src/qemu.git/build/gnuarmeclipse-softmmu/qemu-system-gnuarmeclipse")

# MCUs supported
mcus = ["f103", "f429", "sam3", "k64f","nrf52","nuc123","lpc18","l1521"]
ground_truth_f = {"f103": "STM32F103-GroundTruth.csv", "f429": "STM32F429-GroundTruth.csv", \
    "sam3": "AtmelSAM3-GroundTruth.csv", "k64f": "NXPK64F-GroundTruth.csv",\
    "nrf52": "STM32F103-GroundTruth.csv",  "nuc123": "STM32F103-GroundTruth.csv", \
    "lpc18": "STM32F103-GroundTruth.csv", "l1521": "STM32F103-GroundTruth.csv" }




if len(sys.argv) == 4:

    runpath = getcwd()
    mi_path = runpath + "/../Utilities/me-vera.py"

    try:
       objdump_path =  subprocess.check_output(['which','arm-none-eabi-objdump']).decode()[:-1]
    except:
       sys.exit("arm-none-eabi-objdump not found, verify that the Cortex-M toolchain is installed and added to your PATH")

    model_stat_path = runpath + "/../Utilities/statFp3.py"
    gt_path = runpath + "/../Utilities/p2im-ground_truth"

    # MCUs supported
    mcus = ["f103", "f429", "sam3", "k64f","nrf52","nuc123","lpc18","l1521"]
    ground_truth_f = {"f103": "STM32F103-GroundTruth.csv", "f429": "STM32F429-GroundTruth.csv", \
    "sam3": "AtmelSAM3-GroundTruth.csv", "k64f": "NXPK64F-GroundTruth.csv",\
    "nrf52": "STM32F103-GroundTruth.csv",  "nuc123": "STM32F103-GroundTruth.csv", \
    "lpc18": "STM32F103-GroundTruth.csv", "l1521": "STM32F103-GroundTruth.csv" }

    mcu = sys.argv[1]

    if mcu not in mcus:
        sys.exit("MCU model %s not supported!" % mcu)


    # get file name
    filename = os.path.basename(sys.argv[2])[:-4]
    
    out_path = sys.argv[3] + "/" + filename
    if not os.path.exists(out_path):
        os.makedirs(out_path)

    # model dir
    model_dir = out_path + "/1"

    # delete old model
    shutil.rmtree(model_dir, ignore_errors=True)

    # generate cfg file for model instantiation script
    cfg_f = out_path + "/mi-%s.cfg" % mcu
    cfg_board = {"f103": "NUCLEO-F103RB", "f429": "STM32F429I-Discovery", \
                 "sam3": "Arduino-Due", "k64f": "FRDM-K64F", \
                 "nuc123": "NUVOTON_nuc123", "nrf52": "Nordic_NRF52832", \
				 "lpc18": "NXP_LPC1837", "l1521": "LISA_F105RC" }
    cfg_mcu = {"f103": "STM32F103RB", "f429": "STM32F429ZI", \
               "sam3": "SAM3X8E", "k64f": "MK64FN1M0VLL12", \
			   "nuc123": "NUC123", "nrf52": "NRF52832", \
			   "lpc18": "LPC1837", "l1521":"STM32F105RC"}
    addr_range= {"f103": 1024, "f429": 1024, \
                 "f303":  1024, "sam3": 512, "k64f": 512, \
                 "nuc123": 512, "nrf52": 1024, \
                 "lpc18": 512, "l1521": 512}

    with open(cfg_f, "w") as f:
        f.write("[qemu]\n")
        f.write("bin         = %s\n" % qemu_path)
        f.write("log         = unimp,guest_errors,int\n")
        f.write("run_from_afl         = 0\n\n")
        f.write("len_seeds   = 256\n")
        f.write("len_round   = 50000\n")
        f.write("hang_mode   = 0\n")

        f.write("[program]\n")
        f.write("board       = %s\n" % cfg_board[mcu])
        f.write("mcu         = %s\n" % cfg_mcu[mcu])
        f.write("img         = %s\n\n" % sys.argv[2])

        f.write("[model]\n")
        f.write("retry_num   = 3\n")
        f.write("peri_addr_range = %s\n" % addr_range[mcu])
        f.write("objdump     = %s\n" % objdump_path)
        f.write("log_file    = me.log\n")

    # instantiate model
    subprocess.call([mi_path, "-c", cfg_f, "--run-num", model_dir
                    ])
                    #,"--print-to-file"])

    # rename results
    model_f = out_path + "/model/%s.json" % filename

    # copy model
    try:
        shutil.copyfile("%s/peripheral_model.json" % model_dir, model_f)
    except IOError as io_err:
        os.makedirs(os.path.dirname(model_f))
        shutil.copyfile("%s/peripheral_model.json" % model_dir, model_f)


    # copy dma_trace
    try:
        shutil.copyfile("%s/dma_trace" % model_dir, out_path + "/dma_trace/%s" % filename)
    except:
        os.makedirs(os.path.dirname(out_path + "/dma_trace/%s" % filename))
        shutil.copyfile("%s/dma_trace" % model_dir, out_path + "/dma_trace/%s" % filename)

    # calculate P2IM  model statistics
    stat_f =  out_path + "/statistics/%s" % filename
    if not os.path.exists(os.path.dirname(stat_f)):
        os.makedirs(os.path.dirname(stat_f))
    subprocess.call([model_stat_path, model_f, "%s/%s" % (gt_path, ground_truth_f[mcu]), stat_f])
    #subprocess.call([model_stat_path, model_f, "%s/%s" % (gt_path, ground_truth_f[mcu]), stat_f], stdout=open(model_dir +"/stdout", "a+"), stderr=open(model_dir + "/stderr", "a+"))

    #cleaning up the directory
    shutil.rmtree(model_dir, ignore_errors=True)
    os.remove(cfg_f)


else:
    print("Usage: %s <mcu_model> <firmware_elf> <output_path>" % sys.argv[0])
    print("\tAvailable mcu_model: ", mcus)

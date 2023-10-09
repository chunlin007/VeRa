# VeRa
This is the repo for VeRa：Value Peripheral Register Values for  Fuzzing MCU Firmware. We will open source the tool after the paper is accepted.

.
├── DICE-Evaluation
│   └── ARM
│       ├── DICE-P2IM-Utilities
│       ├── Fuzzing
│       └── Unit-Test
├── p2im
│   ├── afl
│   │   ├── afl-fuzz.c
│   ├── externals
│   ├── fuzzing
│   ├── LICENSE
│   ├── model_instantiation
│   │   ├── fuzz.py
│   │   └── me.py
│   ├── qemu
│   │   └── src  # qemu source code
├── README.md
└── requirement.txt  # required libs

# If you want to run test, just following the tips bellow:

# Build qemu
cd p2im/qemu/src/qemu.git/  
./quick-configure.sh

# Unit Test
## Test one of the firmware
cd Evaluation/ARM/Units/
./run.py <mcu_model> <firmware_elf> <output_path>
For example, ./run.py f103 Firmware/Binaries-P2IM/ARDUINO-F103-ADC.elf outputs

## Test all firmware 
./runbatch.py

# Test Realworld firmware
cd Evaluation/ARM/Fuzzing/
./CreateBaseDir.py -B /root/FuzzBase
FIRMNAME=XXX make clean && FIRMNAME=XXX make run
For example, FIRMNAME=Modbus make clean && FIRMNAME=Modbus make run


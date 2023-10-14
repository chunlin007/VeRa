# VeRa
This is the repo for VeRa：Value Peripheral Register Values for  Fuzzing MCU Firmware. 

```
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
```

# If you want to run test, just following the tips bellow:
# Experiment settings
Ubuntu 18.04 or Docker 

# Upadate submodule 
git submodule init && git submodule update --recursive

# Arm gcc toolchain
Download arm-none-eabi-gcc from: https://drive.google.com/file/d/1TsgGBWBsb4kz6RxHKQnawTzmQ74URD8t/view?usp=drive_link
mv gcc-arm-none-eabi-10.tar.gz /projects
tar xvf gcc-arm-none-eabi-10.tar.gz
ln -sf $PWD/gcc-arm-none-eabi-10/bin/arm-none-eabi-nm /bin/arm-none-eabi-nm
ln -sf $PWD/gcc-arm-none-eabi-10/bin/arm-none-eabi-objdump /bin/arm-none-eabi-objdump

# Build qemu
cd p2im/qemu/src/qemu.git && ./quick-configure.sh

# Build afl
cd p2im/afl && make

# Unit Test
## Test one of the firmware
cd Evaluation/ARM/Units && ./run.py <mcu_model> <firmware_elf> <output_path>
For example, cd Evaluation/ARM/Units/ && ./run.py f103 Firmware/Binaries-P2IM/ARDUINO-F103-ADC.elf outputs

## Test all firmware 
cd Evaluation/ARM/Units && ./runbatch.py

# Test Realworld firmware
cd Evaluation/ARM/Fuzzing && ./CreateBaseDir.py -B FuzzBase && FIRMNAME=XXX make clean && FIRMNAME=XXX make run
For example, FIRMNAME=Modbus make clean && FIRMNAME=Modbus make run


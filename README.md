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

If you want to run test, just following the tips bellow:
# Experiment Environment
Ubuntu 18.04 

# Get vera
```
git clone https://github.com/chunlin007/VeRa.git
git submodule init && git submodule update --recursive
```

# Download arm gcc from Google disk
```
https://drive.google.com/file/d/1TsgGBWBsb4kz6RxHKQnawTzmQ74URD8t/view?usp=drive_link
```

# Install dependency packets
```
./install-requirement.sh
```

# Build qemu
```
cd p2im/qemu/src/qemu.git && ./quick-configure.sh
```

# Build afl
```
cd p2im/afl && make
```

# Unit Test
## Test one of the firmware
```
cd Evaluation/ARM/Units && ./run.py <mcu_model> <firmware_elf> <output_path>
For example, 
cd Evaluation/ARM/Units/ && ./run.py f103 Firmware/Binaries-P2IM/ARDUINO-F103-ADC.elf outputs
```

## Test all firmware 
```
cd Evaluation/ARM/Units && ./runbatch.py
```

# Test Realworld firmware
```
cd Evaluation/ARM/Fuzzing && ./CreateBaseDir.py -B FuzzBase && FIRMNAME=XXX make clean && FIRMNAME=XXX make run
For example, FIRMNAME=Modbus make clean && FIRMNAME=Modbus make run
```

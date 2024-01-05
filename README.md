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

If you want to run test, just follow the tips bellow:
# Experiment Environment
Ubuntu Linux 18.04 

# Get VeRa
```shell
git clone https://github.com/chunlin007/VeRa.git && cd VeRa
```

# Install Dependency Package
```shell
./install-requirements.sh
```

# Build Qemu
```shell
cd p2im/qemu/src/qemu.git && ./quick-configure.sh
```

# Build AFL
```shell
cd p2im/afl && make
```

# Unit Test
## Test One Of The Firmware
```
cd Evaluation/ARM/Units && ./run.py <mcu_model> <firmware_elf> <output_path>
```
For example
```shell
cd Evaluation/ARM/Units/ && ./run.py f103 Firmware/Binaries-P2IM/ARDUINO-F103-ADC.elf outputs
```

## Test All Firmware 
```shell
cd Evaluation/ARM/Units && ./runbatch.py
```

# Test Realworld Firmware
## Create Working Directory
```shell
cd Evaluation/ARM/Fuzzing && ./CreateBaseDir.py -B FuzzBase
```

## Model and Fuzz
```
FIRMNAME=XXX make clean && FIRMNAME=XXX make run
```
For example, 
```shell
FIRMNAME=Modbus make clean && FIRMNAME=Modbus make run
```

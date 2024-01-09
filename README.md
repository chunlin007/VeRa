# VeRa
This is the repo for our paper: [Value Peripheral Register Values for Fuzzing MCU Firmware](https://ieeexplore.ieee.org/document/10301278). 

```
.
├── DICE-Evaluation 
│   └── ARM 
│       ├── DICE-P2IM-Utilities           # Helper scripts written in python.
│       ├── Fuzzing                       # Working directory for realworld firmware. 
│       └── Unit-Test                     # Working directory for unit-test firmware.
├── p2im 
│   ├── afl 
│   │   ├── afl-fuzz.c                    # AFL source code with VeRa plugins (add basic blocks statistics).
│   ├── qemu 
│   │   └── src/qemu.git                  # Qemu source code with VeRa plugins.
├── README.md                             # This file.
└── requirement.txt                       # Required libs.
```

If you want to run test, just follow the tips below:
# Experiment Environment
Ubuntu Linux 18.04 

# Get VeRa
```shell
git clone https://github.com/chunlin007/VeRa.git && cd VeRa
```

# Install Dependency Packages
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
## Test one of the Firmware
```shell
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

## Run Test
```
FIRMNAME=XXX make clean && FIRMNAME=XXX make run
```
For example, 
```shell
FIRMNAME=Modbus make clean && FIRMNAME=Modbus make run
```

# Citing the Paper
In case you would like to cite VeRa, you may use the following BibTex entry:
```
@INPROCEEDINGS{10301278,
  author={Wang, Chunlin and Liang, Hongliang},
  booktitle={2023 IEEE 34th International Symposium on Software Reliability Engineering (ISSRE)}, 
  title={Value Peripheral Register Values for Fuzzing MCU Firmware}, 
  year={2023},
  pages={718-729},
}
```

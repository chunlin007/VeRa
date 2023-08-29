#! /bin/bash

# Replay crash to justify the bug
QEMU_PATH=/project/models/DICE-DMA-Emulation/p2im/qemu/src/qemu.git/build/gnuarmeclipse-softmmu/qemu-system-gnuarmeclipse
BOARD=NUCLEO_F303RE
MCU=STM32F303RE
TARGET_FIRM=/project/models/DICE-DMA-Emulation/DICE-Evaluation/ARM/Fuzzing/Firmware/Binaries/Modbus.elf
WORK_NUM=1.0
MODEL_ROUND=1
FILE_JSON=~/FuzzBase1/Modbus-back/$WORK_NUM/$MODEL_ROUND/peripheral_model.json
DIR_CRASH=~/FuzzBase1/Modbus-back/$WORK_NUM/outputs/crashes

if [ ! -d $DIR_CRASH ] ;then
	echo "Dir $DIR_CRASH not exist !"
	exit -1
fi

if [ ! -f $DIR_JSON ] ;then
	echo "Peripheral model not exist !"
	exit -1
fi

if [ -f ./crash.log ] ;then
	rm -rf ./crash.log
fi

if [ -f ./crash-uniq.log ] ;then
	rm -rf ./crash-uniq.log
fi

$QEMU_PATH -nographic -board $BOARD -mcu $MCU -image $TARGET_FIRM -pm-stage 3 -aflFile $DIR_CRASH/$crashi -model-input $FILE_JSON -gdb tcp::9000 -S



#/project/models/DICE-DMA-Emulation/p2im/qemu/src/qemu.git/build/gnuarmeclipse-softmmu/qemu-system-gnuarmeclipse -nographic -board NUCLEO_F303RE -mcu STM32F303RE -image /project/models/DICE-DMA-Emulation/DICE-Evaluation/ARM/Fuzzing/Firmware/Binaries/Modbus.elf -pm-stage 3 -aflFile ~/FuzzBase1/Modbus-back/1.0/outputs/crashes/id\:000000\,sig\:255\,src\:000000\,op\:havoc\,rep\:16 -model-input ~/FuzzBase1/Modbus-back/1.0/1/peripheral_model.json | tail -n3

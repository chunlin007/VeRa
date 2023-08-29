#! /bin/bash

# Replay crash to justify the bug
:<<EOF
QEMU_PATH=/project/models/DICE-DMA-Emulation/p2im/qemu/src/qemu.git/build/gnuarmeclipse-softmmu/qemu-system-gnuarmeclipse
BOARD=NUCLEO_F303RE
MCU=STM32F303RE
TARGET_FIRM=/project/models/DICE-DMA-Emulation/DICE-Evaluation/ARM/Fuzzing/Firmware/Binaries/Modbus.elf
WORK_NUM=1.0
MODEL_ROUND=1
FILE_JSON=~/FuzzBase1/Modbus-back/$WORK_NUM/$MODEL_ROUND/peripheral_model.json
DIR_CRASH=~/FuzzBase1/Modbus-back/$WORK_NUM/outputs/crashes
EOF
# Auto load configuration from the XXX.cfg
WORK_ROOT=`pwd | awk -F'/DICE-' '{print $1}'`
DIR_FUZZ=$WORK_ROOT/DICE-advance/DICE-Evaluation/ARM/Fuzzing
DIR_CONFIG=$DIR_FUZZ/Configs
FIRMNAME=""
BOARD=""
MCU=""
WORK_NUM=1.0
TARGET_FIRM=""
if [ ! -z $1 ]; then
	FIRMNAME+=$1
else
	FIRMNAME=Soldering-Station
	#echo "Please input firmware name"
	#exit 1
fi

ROOT_RESULT=~/FuzzBase2/$FIRMNAME/$WORK_NUM
#DIR_CRASH=$ROOT_RESULT/outputs/crashes
DIR_CRASH=$ROOT_RESULT/outputs/hangs
RESULT_CONFIG=$ROOT_RESULT/mi-f103.cfg
FILE_JSON=$ROOT_RESULT/1/peripheral_model.json
FILE_CONFIG=$DIR_CONFIG/$FIRMNAME".cfg"
QEMU_PATH=""

if [ -z $WORK_NUM ];then
	WORK_NUM=`cat $FILE_CONFIG | grep 'run ' | awk -F'=' '{print $2}' \
		| sed s/[[:space:]]//g`
fi

if [ -z $BOARD ];then
	BOARD=`cat $RESULT_CONFIG | grep 'board ' | awk -F'=' '{print $2}' \
        | sed s/[[:space:]]//g`
fi

if [ -z $MCU ];then
	MCU=`cat $RESULT_CONFIG | grep 'mcu ' | awk -F'=' '{print $2}' \
        | sed s/[[:space:]]//g`
fi

if [ -z $QEMU_PATH ];then
	QEMU_PATH=`cat $RESULT_CONFIG | grep 'bin ' | awk -F'=' '{print $2}' \
        | sed s/[[:space:]]//g`
fi

if [ -z $TARGET_FIRM ];then
	TARGET_FIRM=$DIR_FUZZ/Firmware/Binaries/$FIRMNAME".elf"
fi

if [ ! -d $DIR_CRASH ] ;then
	echo "Dir $DIR_CRASH not exist !"
fi

if [ ! -f $FILE_JSON ] ;then
	echo "Peripheral model not exist !"
fi

if [ -f ./crash.log ] ;then
	rm -rf ./crash.log
fi

if [ -f ./crash-uniq.log ] ;then
	rm -rf ./crash-uniq.log
fi


for crashi in `ls $DIR_CRASH`
do
	if [ $crashi == "README.txt" ];then
		continue
	fi
	echo "Replaying with "$crashi
	$QEMU_PATH -nographic -board $BOARD -mcu $MCU -image $TARGET_FIRM -pm-stage 3 -aflFile $DIR_CRASH/$crashi -model-input $FILE_JSON 2>&1 | tail -n 2 \
			>> ./crash.log 
	#sleep 1
done

cat ./crash.log | grep "illegal" | sort | uniq -c > ./crash-uniq.log
wc -l ./crash-uniq.log >> ./crash-uniq.log
cat ./crash-uniq.log | awk -F'[' '{print $2}' | awk -F']' '{print $1}' | sort | uniq -c > ./crash-block.log
#rm -rf ./crash.log

#sleep 1
stty echo 
#/project/models/DICE-DMA-Emulation/p2im/qemu/src/qemu.git/build/gnuarmeclipse-softmmu/qemu-system-gnuarmeclipse -nographic -board NUCLEO_F303RE -mcu STM32F303RE -image /project/models/DICE-DMA-Emulation/DICE-Evaluation/ARM/Fuzzing/Firmware/Binaries/Modbus.elf -pm-stage 3 -aflFile ~/FuzzBase1/Modbus-back/1.0/outputs/crashes/id\:000000\,sig\:255\,src\:000000\,op\:havoc\,rep\:16 -model-input ~/FuzzBase1/Modbus-back/1.0/1/peripheral_model.json | tail -n3

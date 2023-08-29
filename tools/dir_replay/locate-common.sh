#! /bin/bash

# Chunlin:
#	Locate the blocks which contain the illegal operation according to the crash seeds
#

# Auto load configuration from the XXX.cfg
WORK_ROOT=`pwd|awk -F'/VeRa' '{print $1}'`
DIR_FUZZ=$WORK_ROOT/VeRa/Evaluation/ARM/Fuzzing
DIR_CONFIG=$DIR_FUZZ/Configs
FIRMNAME=""
BOARD=""
MCU=""
WORK_NUM=1.0
TARGET_FIRM=""
if [ ! -z $1 ]; then
	FIRMNAME+=$1
else
	FIRMNAME=Modbus
fi

#Modify PERI_MODEL to the last model used by mbdfuzzer
PERI_MODEL=0.input.data.1
RESULT_ROOT=~/FuzzBase
RESULT_DIR=$RESULT_ROOT/$FIRMNAME/$WORK_NUM
DIR_CRASH=$RESULT_DIR/outputs/crashes
RESULT_CONFIG=""
FILE_JSON=$RESULT_DIR/$PERI_MODEL/peripheral_model.json
echo $FILE_JSON
FILE_CONFIG=$DIR_CONFIG/$FIRMNAME".cfg"
QEMU_PATH=""
LEN_SEEDS=""
LEN_ROUND=""


if [ -z $RESULT_CONFIG ];then
	RESULT_CONFIG=$RESULT_DIR"/mi-"`cat $FILE_CONFIG | grep 'mcu ' | awk -F'=' '{print $2}' \
		| sed s/[[:space:]]//g`".cfg"
fi

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

if [ -z $LEN_SEEDS ];then
	LEN_SEEDS=`cat $RESULT_CONFIG | grep 'len_seeds ' | awk -F'=' '{print $2}' \
        | sed s/[[:space:]]//g`
fi

if [ -z $LEN_ROUND ];then
	LEN_ROUND=`cat $RESULT_CONFIG | grep 'len_round ' | awk -F'=' '{print $2}' \
        | sed s/[[:space:]]//g`
fi

if [ -z $TARGET_FIRM ];then
	TARGET_FIRM=$DIR_FUZZ/Firmware/Binaries-No-Ins/$FIRMNAME".elf"
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
	$QEMU_PATH -nographic -board $BOARD -mcu $MCU -image $TARGET_FIRM -pm-stage 3 -aflFile $DIR_CRASH/$crashi -model-input $FILE_JSON -run-from-afl -len-seeds $LEN_SEEDS -len-round $LEN_ROUND 2>&1 | tail -n 7 >> ./crash.log 
	echo "-----------$crashi------------">>./crash.log
	#sleep 1
done

cat ./crash.log | grep "illegal" | sort | uniq -c > ./crash-uniq.log
wc -l ./crash-uniq.log >> ./crash-uniq.log
cat ./crash-uniq.log | awk -F'[' '{print $2}' | awk -F']' '{print $1}' | sort | uniq -c > ./crash-block.log
#rm -rf ./crash.log 

echo "Analysis Complete!"
echo "More Details in :"
echo "	[1] crash-uniq.log <All Qemu Blocks contains illegal operation>"
echo "	[2] crash-uniq.log <Uniq Qemu Block contains illegal operation>"
#sleep 1
stty echo 
#/project/models/DICE-DMA-Emulation/p2im/qemu/src/qemu.git/build/gnuarmeclipse-softmmu/qemu-system-gnuarmeclipse -nographic -board NUCLEO_F303RE -mcu STM32F303RE -image /project/models/DICE-DMA-Emulation/DICE-Evaluation/ARM/Fuzzing/Firmware/Binaries/Modbus.elf -pm-stage 3 -aflFile ~/FuzzBase1/Modbus-back/1.0/outputs/crashes/id\:000000\,sig\:255\,src\:000000\,op\:havoc\,rep\:16 -model-input ~/FuzzBase1/Modbus-back/1.0/1/peripheral_model.json | tail -n3

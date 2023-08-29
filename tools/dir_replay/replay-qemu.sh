#! /bin/bash

# Chunlin:
#	Locate the blocks which contain the illegal operation according to the crash seeds
#

# Auto load configuration from the XXX.cfg
WORK_ROOT=`pwd|awk -F'/DICE-advance' '{print $1}'`
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
	FIRMNAME=Modbus
fi

#Modify PERI_MODEL to the last model used by mbdfuzzer
PERI_MODEL=0.input.data.5
RESULT_ROOT=~/FuzzBase2
RESULT_DIR=$RESULT_ROOT/$FIRMNAME/$WORK_NUM
DIR_CRASH=$RESULT_DIR/outputs/crashes
RESULT_CONFIG=""
FILE_JSON=$RESULT_DIR/$PERI_MODEL/peripheral_model.json
FILE_CONFIG=$DIR_CONFIG/$FIRMNAME".cfg"
QEMU_PATH=""
LEN_SEEDS=""
LEN_ROUND=""

if [ -z $RESULT_CONFIG ];then
    RESULT_CONFIG=$RESULT_DIR"/mi-"`cat $FILE_CONFIG | grep 'mcu ' | awk -F'=' '{print $2}' | sed s/[[:space:]]//g`".cfg"
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

for crashi in `ls $DIR_CRASH`
do
    if [ $crashi != "README.txt" ];then
        break
    fi
done

$QEMU_PATH -nographic -board $BOARD -mcu $MCU -image $TARGET_FIRM -pm-stage 3 -aflFile $DIR_CRASH/$crashi -model-input $FILE_JSON -run-from-afl -len-seeds $LEN_SEEDS -len-round $LEN_ROUND -gdb tcp::9000 -S

#! /bin/bash
# Track the real execution of firmware. The 
# 1. Add #define __OPEN_DETAIL_LOG to qemu.git/target-arm/translate.c
# 2. make -C build -j
# 3. cd ../../../../DICE-Evaluation/ARM/Fuzzing && make clean && make run
# 4. Stop and execute term below
# 5. Analyze the log file and create new log about which line the dice-pro 
#    can not execute

echo "Analyzing..."
WORK_ROOT=`pwd | awk -F'/DICE-' '{print $1}'`
# Create modbus-text-uniq.s
PATH_TO_FIRMWARE=$WORK_ROOT/DICE-advance/DICE-Evaluation/ARM/Unit-Test/Firmware/Binaries-DICE
FIRMNAME=F103_ADC_SingleConversion_TriggerSW_DMA # replace this with the firmware name which will be tested
FILE1=./disas_insn_uniq.log
FILE2=./$FIRMNAME-text.s

# Abstract the .text section of firmware
arm-none-eabi-objdump -d -j.text $PATH_TO_FIRMWARE/$FIRMNAME.elf \
		> $FILE2

# Compress the size of log file
for logi in `ls /tmp/disas_arm_insn_*`
do
	#echo $logi
	cat $logi | sort | uniq > $logi"_p"
	rm -rf $logi
done

cat /tmp/disas_arm_insn_*_p | sort | uniq > $FILE1
# Comment line in FILE2 according to pc in file1
num1=`egrep "^ 8[0-9a-f]{6}:" $FILE2 | egrep -v "word" |  wc -l`
num2=0

if [ -f ./num.log ];then
	rm -rf ./num.log
fi

for line in `cat $FILE1`
do 
	#echo $line
	#egrep -n "$line:|0$line <" $FILE2 | awk -F':' '{print $1}'; 
	for num in `egrep -n "$line:|0$line <[0-9a-zA-Z_-]*>:" $FILE2 | awk -F':' '{print $1}'`
	do
		echo $num >> ./num.log
	done

	let num2+=1
done

cat ./num.log | sort | uniq -c | awk -F' ' '{print $2}' > ./num-uniq.log
for num in `cat ./num-uniq.log`
do
	sed -i "$num s/^/#&/" $FILE2
done

rm -rf ./num.log ./num-uniq.log $FILE1
# Print result
echo "Analyze complete !"
echo "There are "$num2" lines that DICE-PRO can not coverage."
rate=$(printf "%.2f" `echo "scale=6;$num2 / $num1 * 100" | bc`)
echo "The code coverage rate of this analysis is: %"$rate
echo "    More details in "$FIRMNAME-text.s
echo "    Note: The term which DICE-Pro can coverage commented by #"

#! /bin/bash

DIROOT=~/FuzzBase2/Modbus/1.0/0/sr_input-depth\:$1//
#WORKDIR=$(DIROOT)/$(SUBDIR)

#echo $WORKDIR
for file in `ls $DIROOT`
do
		#hexdump $DIROOT/$file
		num=`hexdump $DIROOT/$file | awk -F' ' 'NR==1{print $2 $3}'`
		#echo $num
		# The bc can not deal with a-f in hex value, so use rax2
		#echo "ibase=16;obase=2; $num"|bc >> /tmp/sr_in 
		rax2 "Bx"$num | awk -F'b' '{print $1}' >> /tmp/sr_in
done
cat /tmp/sr_in | sort

rm /tmp/sr_in

#for name in `ls /tmp/sr_inputs`; do num=`cat "/tmp/sr_inputs/"$name | hexdump | awk -F' ' 'NR=1{print $2 $3}'`; rax2 "Bx"$num ;done

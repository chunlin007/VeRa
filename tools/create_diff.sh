#! /bin/bash


ROOT1=~/FuzzBase2/Modbus/1.0/0/sr_input-depth\:1
ROOT3=~/FuzzBase2/Modbus/1.0/0/sr_input-depth\:3
ROOT4=~/FuzzBase2/Modbus/1.0/0/sr_input-depth\:4

for file in `ls $ROOT1` ;
do 
	diff $ROOT1/$file $ROOT3/$file > /tmp/file13.diff 
	diff $ROOT3/$file $ROOT4/$file > /tmp/file34.diff 
		 
done

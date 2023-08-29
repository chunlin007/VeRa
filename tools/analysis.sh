#! /bin/bash 

for log in `ls /tmp/afl-out*`
do 
	sed -i 's/(qemu) //g' $log
	name=$log.info
	#echo $name
	grep -I retval $log | sort -u > $name
done


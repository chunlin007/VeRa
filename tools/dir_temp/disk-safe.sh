#! /bin/bash

kill_signal() {
	#echo "Detecting the disk of "$firmware > /tmp/cron.log
	space=`du -sh -m $1 | awk -F ' ' '{printf("%d", $1)}'`
	if [ $space -gt 20480 ]; then
		ps aux | grep $2 | grep afl-fuzz | awk -F' ' '{print $2}' #| xargs kill -9	
		echo "Over disk limit, so we must stop analyzing $2" >> /tmp/disk-safe.log
	fi
}

for item in `ps aux | grep FuzzBase | awk -F' ' '{print $13}' | grep / | awk -F'/' '{print $3"/"$4}'`
do
	dirname=`echo $item | awk -F'/' '{print $1}'`
	firmware=`echo $item | awk -F'/' '{print $2}'`
	dir=/root/$dirname/$firmware
	if [ -d $dir ]; then
		kill_signal $dir $firmware
	fi
done

# */1 *   * * *   root    /home/chunlin/TSIS/dir_analyze/DICE-advance/tools/dir_temp/disk-safe.sh
# /etc/crontab

#!/bin/bash

filename=$1 
symbol=$2 
 
if [ -z "$filename" ]; then 
    echo "usage : $0 filename symbol"
    exit 
fi 
 
startaddress=$(arm-none-eabi-nm  -n $filename | grep "\w\s$symbol" | awk '{print "0x"$1;exit}') 
endaddress=$(arm-none-eabi-nm -n $filename | grep -A1 "\w\s$symbol" | awk '{getline; print "0x"$1;exit}') 
  
if [ -z "$symbol" ]; then 
    echo "dump all symbol"
    arm-none-eabi-objdump -d $filename 
else 
    echo "start-address: $startaddress, end-address: $endaddress" 
    arm-none-eabi-objdump -d $filename --start-address=$startaddress --stop-address=$endaddress
fi

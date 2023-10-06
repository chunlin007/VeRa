#! /bin/bash
for file in `ls Configs/`
do 
	filep=$PWD"/Configs/"$file; 
	echo $filep; 
	#sed -i -e  's/2019-2020/2023-2024/g' -e 's/RiS3/TSIS/g' -e 's/DICE /VeRa /g' -e 's/DICE-P2IM-Utilities/Utilities/g' $filep
	sed -i -e 's/me-multi/me/g' $filep
done

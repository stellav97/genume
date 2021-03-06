#!/bin/bash

#looks for all the storage devices
dir=$(cat /proc/partitions | grep -E -o '\<[s][r][[:alpha:]]*[0-9]\>|\<[s][d][[:alpha:]]*\>|\<[h][d][[:alpha:]]*\>')

cnt=0
#counts the storage devices
for i in $dir
do
        cnt=$[ $cnt + 1 ]
done
echo VALUE BAS connected_storage_devices ${cnt}

for i in $dir
do
	par=$(cat /proc/partitions | grep -o $i[0-9])
	partitions=0
	for j in $par
	do
		partitions=$[partitions + 1]
	done
	if [ -f /sys/class/block/$i/device/model ]
	then
		model=$(cat /sys/class/block/$i/device/model)
		echo VALUE BAS model_$i \"$model\"
	fi
	if [ -f /sys/class/block/$i/device/vendor ]
	then
		vendor=$(cat /sys/class/block/$i/device/vendor)
		echo VALUE ADV vendor_$i \"$vendor\"
	fi	
	if [ -f /sys/class/block/$i/size ]
	then
		size=$(cat /sys/class/block/$i/size)
		echo VALUE BAS size_$i \"$size blocks\"
	fi
	if (($partitions > 0))
	then
		echo VALUE BAS partitions_$i \"$partitions\"
	fi
done


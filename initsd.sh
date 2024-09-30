#!/usr/bin/env bash

SDCARD_PATH=/media/user/bootfs
CONFIG_TXT=config.txt
CMDLINE_TXT=cmdline.txt

# read SD card
function detectSD(){
	while true; do
		if [ -d "${SDCARD_PATH}" ];then
			echo "SD card was found!"
			return
		fi
		sleep 1
	done
}
# 1
echo before detectSD
detectSD
echo after detectSD



# find config.txt cmdline.txt
function detectCMDLINE(){
	sleep 1
	if [ -f "${SDCARD_PATH}/${CMDLINE_TXT}" ];then
		# echo "SD card was found!"
		return 0 #find
	else
		return 1 #Not find
	fi
}

# 2 find cmdline.txt file
isCMDLINE=`detectCMDLINE`
IPADDR=192.168.111.1
if [ $isCMDLINE -eq 0 ];then
	# find 192.168.111.1 & modify
	sed "s/${IPADDR}/111.111.111.111/" "${SDCARD_PATH}/${CMDLINE_TXT}"
	
	if [ $? -eq 0 ];then
		echo "${CMDLINE_TXT} file was modified. SUCCESS!"
	else
		echo "${CMDLINE_TXT} file was not modified. FAIL!"
	fi
fi


# unmount /media/user/bootfs
umount /media/user/bootfs
echo "You can remove SDCARD."
#* * * * * /home/user/Desktop/initsd.sh > /home/user/Desktop/initsd.log

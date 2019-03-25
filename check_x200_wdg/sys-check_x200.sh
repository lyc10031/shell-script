#!/bin/bash

PORT=/dev/ttyUSB0
BAUD=115200

set_band(){
	stty -F ${PORT} ${BAUD}
	if [ $? != 0 ];then
		echo "set band failed.\n"
		exit 1
	fi
}
#可以设置两个参数，第一个参数为寄存器地址，第二个参数为寄存器的值
write_register_value(){
	addr=$1
	value=$2
	echo -e "write $addr=$value\n" > ${PORT}
}


REBOOT=49  #mcu control power reboot, 0x01=start reboot


check () {
  sleep 60
  set_band
  lsmod | grep x200 > /dev/null || modprobe x200
  sleep 5
#  cat /proc/interrupts  | grep x200 | awk -F ' ' '{print $2,$3,$4,$5}' | grep [1-9] > /dev/null && echo "True" || echo "Fault"
  cat /proc/interrupts  | grep x200 | awk -F ' ' '{print $2,$3,$4,$5}' | grep [1-9] > /dev/null && echo "True" || write_register_value ${REBOOT} "01h"
}

check 

#!/bin/sh

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


WDG_EN=51  #watch dog enable, 0x00=disable
WDG_CLR=52  #watch dog clear, 0x00=clear
WDG_TIME=53  #watch dog time, 10s/tick

main(){
	set_band
	write_register_value ${WDG_TIME} "0Ch" #deadline time 120s
    sleep 1
    write_register_value ${WDG_EN} "01h"  #enable watchdog
    sleep 1
	while [ true ]
	do
		write_register_value  ${WDG_CLR} "00h"  #feed dog
		sleep 5
	done
}



main

#!/bin/bash

test_emmc_io () {
	rm -rf /mnt/emmc_io_test/read_test.log

	echo -e "\n" >> /root/write_test.log
	dd if=/dev/zero of=/mnt/emmc_io_test/read_test.log bs=1M count=15k conv=fsync 2>> /root/write_test.log
	echo -e "\n" >> /root/write_test.log

	echo -e "\n" >> /root/read_test.log
	dd if=/mnt/emmc_io_test/read_test.log of=/dev/null bs=1M count=15k  2>> /root/read_test.log
	echo -e "\n" >> /root/read_test.log
}


for ((i=1;i<=300;i++))
do
test_emmc_io
done


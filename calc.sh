#!/bin/bash

#cat /dev/null > R.log && cat /dev/null > W.log && cat read_test.log | grep "GB" | awk -F ' ' '{print $8}'>> R.log && cat write_test.log | grep "GB" | awk -F ' ' '{print $8}'>> W.log

echo -e "\n << Tested  `cat R.log | wc -l` times .. >>\n"

calc () {
R_1=`awk '{sum+=$1} END {print "Read_Avg: ", sum/NR}' R.log`
R_2=`awk 'BEGIN {max = 0} {if ($1+0 > max+0) max=$1} END {print "Read_Max: ", max}' R.log`
R_3=`awk 'BEGIN {min = 65536} {if ($1+0 < min+0) min=$1} END {print "Read_Min: ", min}' R.log`

W_1=`awk '{sum+=$1} END {print "Write_Avg: ", sum/NR}' W.log`
W_2=`awk 'BEGIN {max = 0} {if ($1+0 > max+0) max=$1} END {print "Write_Max: ", max}' W.log`
W_3=`awk 'BEGIN {min = 65536} {if ($1+0 < min+0) min=$1} END {print "Write_Min: ", min}' W.log`


echo -e " $R_1 \n $R_2 \n $R_3 \n\n $W_1 \n $W_2 \n $W_3 \n"

}

calc 

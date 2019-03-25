#!/bin/bash
time1=`date "+%Y-%m-%d %H:%M:%S"`
#time1=`date -d"$A" +%s`
echo " ___________________________________________" >> cpus.txt
echo "|                                           |" >> cpus.txt
cpu_info=`cat /proc/cpuinfo  | grep "model name" | uniq  | awk -F ":" '{print $2}' |sed 's/[ ][ ]*/ /g'`
echo "|$cpu_info   |">> cpus.txt
echo "|  `free -h | grep "Mem" | awk '{print "Mem_totle: "$2}'`" >> cpus.txt
echo "|********CPU_Idle(%) and Mem_free(%)********|" >> cpus.txt
echo "|******Start Time:$time1*******|    " >> cpus.txt
totle=`free -m | grep -i 'Mem'| awk -F ' ' '{print $2}'`

sync; echo 1 > /proc/sys/vm/drop_caches  # 清空缓存
if [ ! -d "tmp" ]; then
 mkdir "tmp"
fi

#cat /dev/null > cpus.txt
for i in {1..10}
do
if [ $i -lt 10 ];then 
#    A=`top -b -n 2 | grep %Cpu |awk NR==2 | awk -F ',' '{print $4}' | awk  '{print $1}'`
    A=`top -b -n 2 | grep %Cpu | awk -F ',' '{print $4}' | awk  '{print $1}'`
   # B=`top -b -n 1 | grep -i 'KiB Mem' | awk -F ',' '{print $1}' | awk '{print $4}'`
    C=`free -m | grep -i 'Mem'| awk -F ' ' '{print $4}'`
   # D=`expr $C / $B`
    echo $C >> tmp/tmp_Mem.txt
    echo $A >> tmp/tmp_Idle.txt
#    i=`expr $i + 1`
    i=$(($i + 1))
    sleep $1
else
#    B=`awk -F' ' '{sum+=$1;count+=1} END{print "SUM:"sum"\nAVG:"sum/count}' tmp.txt`
#    B=`awk -F' ' '{sum+=$1;count+=1} END{print "AVG:"sum/count}' tmp.txt`
    E=`awk '{sum+=$1} END {print "CPU_idle_Avg: ", sum/NR}' tmp/tmp_Idle.txt`
    F=`awk 'BEGIN {max = 0} {if ($1+0 > max+0) max=$1} END {print "CPU_idle_Max: ", max}' tmp/tmp_Idle.txt`
    G=`awk 'BEGIN {min = 65536} {if ($1+0 < min+0) min=$1} END {print "CPU_idle_Min: ", min}' tmp/tmp_Idle.txt`
   # H=`awk '{sum+=$1} END {print "CPU_Mem_Avg: ", sum/NR/7810}' tmp_Mem.txt`
    H=`awk -v totle=$totle '{sum+=$1} END {print "Mem_Avg: ", (sum/NR/totle)*100}' tmp/tmp_Mem.txt`
    I=`awk -v totle=$totle 'BEGIN {max = 0} {if ($1+0 > max+0) max=$1} END {print "Mem_Max: ", (max/totle)*100}' tmp/tmp_Mem.txt`
    J=`awk -v totle=$totle  'BEGIN {min = 65536} {if ($1+0 < min+0) min=$1} END {print "Mem_Min: ", (min/totle)*100}' tmp/tmp_Mem.txt`
    echo " $E " >> cpus.txt
    echo " $F " >> cpus.txt
    echo " $G " >> cpus.txt
    echo " ----------" >> cpus.txt
#    echo " `free -m | grep "Mem" | awk '{print "Mem_totle: "$2}'`" >> cpus.txt
    echo " $H " >> cpus.txt
    echo " $I " >> cpus.txt
    echo " $J " >> cpus.txt
fi
done
cat /dev/null > tmp/tmp_Idle.txt
cat /dev/null > tmp/tmp_Mem.txt
time2=`date "+%Y-%m-%d %H:%M:%S"`
Times1=`date -d"$time1" +%s`
Times2=`date -d"$time2" +%s`
time3=`expr $Times2 - $Times1`
time4=`date -d @$time3 +%M:%S`
echo "|*******End Time:$time2********|" >> cpus.txt
echo "|*************Duration($time4)***************|" >> cpus.txt
echo "|___________________________________________|" >> cpus.txt
echo -e " \n " >> cpus.txt
sleep 2
cat cpus.txt

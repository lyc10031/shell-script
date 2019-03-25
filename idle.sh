#!/bin/bash
if [ ! $# == 1 ]; then
echo -e " Usage: ./idle.sh 1 \n[Means getting 10 seconds of information about CPU and memory]"
exit 2
else
sh get_info.sh $1
fi

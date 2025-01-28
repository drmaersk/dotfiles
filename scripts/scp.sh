#!/usr/bin/env bash
#
arg_count=$#
copyToPath="/home/roberth/Downloads/"
args=""
copyFromPath=""

if [ $# -eq 1 ]; then
   copyFromPath=$1
elif [ $# -eq 2 ]; then
        copyFromPath=$1
        copyToPath=$2
elif [ $# -eq 3 ]; then
        args=$1
        copyFromPath=$2
        copyToPath=$3
else
    echo "Wrong arguments provided."
    exit 1
fi

echo "scp $args roberth@172.20.21.111:$copyFromPath $copyToPath"

sshpass -p robban9696 scp $args roberth@172.20.21.111:$copyFromPath $copyToPath

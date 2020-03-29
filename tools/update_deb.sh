#! /usr/bin/env bash

{
apt-get update
apt-get upgrade -y
} >> ../../kalibuntu.log 2>&1
echo " "
echo "Updates finished"
clear
cd ..
./kalibuntu.sh
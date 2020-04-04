#! /usr/bin/env bash

source ../spinner.sh

start_spinner 'Updating packages'
{
apt-get update
apt-get upgrade -y
} >> ../../kalibuntu.log 2>&1
stop_spinner $?
echo " "
echo "Updates finished"
clear
cd ..
./kalibuntu.sh
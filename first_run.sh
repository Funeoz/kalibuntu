#! /usr/bin/env bash

source spinner.sh

start_spinner 'Installing needed tools for Kalibuntu...'
{
apt-get update
apt-get install python3-pip git -y
pip3 install --user lastversion
} >> ../../kalibuntu.log 2>&1
stop_spinner $?


echo "Finished installing... Going to Kalibuntu main menu"
sleep 2
./kalibuntu.sh

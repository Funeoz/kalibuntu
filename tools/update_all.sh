#! /usr/bin/env bash

source ../spinner.sh

start_spinner 'Updating all tools'

# updating .deb-based tools first
{
./update_deb.sh

# updating packages downloaded from GitHub, pip and anything else than .deb
# by sourcing and calling functions

find . -type f -iname "*.sh" -exec source {} \;

update_sqlmap
update_wpscan
update_bettercap
update_apktool
#update_ghidra
update_arduino
update_metagoofil
} >> ../../kalibuntu.log 2>&1

stop_spinner $?
echo " "
echo "Updates finished. Returning to main menu..."
cd .. || exit
./kalibuntu.sh

#! /usr/bin/env bash

p1_tools=("aircrack-ng" "pixiewps" "back")

return_to_menu () {
    clear
    cd ../.. || exit
    ./kalibuntu.sh
    return
}

main () {
    . banner.sh
    tput bold
    echo "Available Wireless attacks tools:"
    tput sgr0
    echo " "
    select choice in ${p1_tools[*]}; do
        case $choice in
            aircrack-ng) 
                clear
                ./aircrack-ng.sh
                break
                ;;
            pixiewps)
                clear
                ./pixiewps.sh
                break
                ;;
            back) 
                return_to_menu
                break
                ;;
            *)
                main
                break
                ;;
        esac
    done
    return
}

main
#! /usr/bin/env bash

p1_tools=("nmap" "wireshark" "back")

return_to_menu () {
    clear
    cd ../.. || exit
    ./kalibuntu.sh
    return
}

main () {
    . banner.sh
    tput bold
    echo "Available Information gathering tools:"
    tput sgr0
    echo " "
    select choice in ${p1_tools[*]}; do
        case $choice in
            nmap) 
                clear
                ./nmap.sh
                break
                ;;
            wireshark) 
                clear
                ./wireshark.sh
                break
                ;;
            back) 
                return_to_menu
                break
                ;;
            *)
                choice
                break
                ;;
        esac
    done
    return
}

main
#! /usr/bin/env bash

p1_tools=("dumpzilla" "back")

return_to_menu () {
    clear
    cd ../.. || exit
    ./kalibuntu.sh
    return
}

main () {
    . banner.sh
    tput bold
    echo "Available Forensics tools:"
    tput sgr0
    echo " "
    select choice in ${p1_tools[*]}; do
        case $choice in
            dumpzilla) 
                clear
                ./dumpzilla.sh
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
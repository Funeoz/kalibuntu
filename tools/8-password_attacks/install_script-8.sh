#! /usr/bin/env bash

p1_tools=("hydra" "hashcat" "back")

return_to_menu () {
    clear
    cd ../.. || exit
    ./kalibuntu.sh
    return
}

main () {
    . banner.sh
    tput bold
    echo "Available Password attacks tools:"
    tput sgr0
    echo " "
    select choice in ${p1_tools[*]}; do
        case $choice in
            hashcat)
                clear
                ./hashcat.sh
                break
                ;;
            hydra) 
                clear
                ./hydra.sh
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
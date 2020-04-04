#! /usr/bin/env bash

check_sudo () {
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root" 
        exit 1
    fi
    return
}

COLUMNS=4
kalibuntu () {
    source spinner.sh

    start_spinner 'Cleaning log'
    rm kalibuntu.log
    touch kalibuntu.log
    sleep 2
    stop_spinner $?


    clear

    echo "export PATH=$PATH:$(pwd)" >> ~/.profile
    source ~/.profile
    . banner.sh

    # create this variable to run commands in child scripts with normal user 
    export DEFAULT_USER=$SUDO_USER

    # display banner
    echo " "
    tput bold
    echo "Select the category of your tool (enter number):"
    tput sgr 0
    echo " "

    categories=("Information_Gathering" "Vulnerability_Analysis" "Wireless_Attacks" "Web_Applications" 
    "Exploitation_Tools" "Forensics_Tools" "Sniffing_Spoofing" "Password_Attacks" "Reverse_Engineering"
    "Hardware_Hacking" "Reporting_Tools" "Update_all" "exit") 

    select category in ${categories[*]}; do
        case $category in 
            Information_Gathering)
                clear
                cd tools/1-information_gathering/ || exit
                ./install_script-1.sh
                break
                ;;
            Vulnerability_Analysis) 
                clear
                cd tools/2-vulnerability_analysis/ || exit
                ./install_script-2.sh 
                break
                ;;
            Wireless_Attacks)
                clear
                cd tools/3-wireless_attacks/ || exit
                ./install_script-3.sh
                break
                ;;
            Web_Applications)
                clear
                cd tools/4-web_applications/ || exit
                ./install_script-4.sh
                break
                ;;
            Exploitation_Tools)
                clear
                cd tools/5-exploitation_tools/ || exit
                ./install_script-5.sh
                break
                ;;
            Forensics_Tools)
                clear
                cd tools/6-forensics_tools/ || exit
                ./install_script-6.sh
                break
                ;;
            Sniffing_Spoofing)
            clear
                cd tools/7-sniffing_spoofing/ || exit
                ./install_script-7.sh
                break
                ;;
            Password_Attacks)
                clear
                cd tools/8-password_attacks/ || exit
                ./install_script-8.sh
                break
                ;;
            Reverse_Engineering)
                clear
                cd tools/9-reverse_engineering/ || exit
                ./install_script-9.sh
                break
                ;;
            Hardware_Hacking)
                clear
                cd tools/10-hardware_hacking/ || exit
                ./install_script-10.sh
                break
                ;;
            Reporting_Tools)
                clear
                cd tools/11-reporting_tools/ || exit
                ./install_script-11.sh
                break
                ;;
            Update_all)
                cd tools/ || exit
                ./update_all.sh
                break
                ;;
            exit)
                clear 
                exit
                ;;
            *)
                kalibuntu
                break
                ;;
        esac
    done
    return
}

check_sudo

kalibuntu

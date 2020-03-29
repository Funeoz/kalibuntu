#! /usr/bin/env bash

install_metagoofil () {
    {
    cd ../.. || exit
    cd binaries || exit
    git clone https://github.com/opsdisk/metagoofil.git
    cd metagoofil || exit
    pip3 install -r requirements.txt
    cd ../.. || exit
    cd tools/11-reporting_tools || exit
    echo " "
    echo "Installation finished"
    return
    } >> ../../kalibuntu.log 2>&1
}

uninstall_metagoofil () {
    {
    cd ../.. || exit
    cd binaries || exit
    rm -rf metagoofil
    cd .. || exit
    cd tools/11-reporting_tools || exit
    pip3 uninstall google -y
    pip3 uninstall requests -y
    } >> ../../kalibuntu.log 2>&1
    echo " "
    echo "Uninstallation finished"
    return
}

update_metagoofil () {
    {
    cd ../.. || exit
    cd binaries || exit
    rm -rf metagoofil
    git clone https://github.com/opsdisk/metagoofil.git
    } >> ../../kalibuntu.log 2>&1
    echo " "
    echo "Upgrade finished"
    return
}

return_to_install_script-11 () {
    clear
    ./install_script-11.sh
    return
}

main () {
    clear
    . banner.sh
    tput bold
    echo "Install/Uninstall/Update metagoofil (based on opsdisk/metagoofil) ?"
    tput sgr0
    echo " "

    select choice in Install Uninstall Update back; do
        case $choice in 
        Install)
            install_metagoofil
            break
            ;;
        Uninstall)
            uninstall_metagoofil
            break
            ;;
        Update)
            update_metagoofil
            break
            ;;
        back)
            return_to_install_script-11
            break
            ;;
        *)
            clear
            main
            break
            ;;
        esac
    done
    return
}

main
#! /usr/bin/env bash

install_metagoofil () {
    start_spinner 'Installing metagoofil'
    {
    cd ../.. || exit
    cd binaries || exit
    git clone https://github.com/opsdisk/metagoofil.git
    cd .. || exit
    cd tools/11-reporting_tools || exit
    su - "$DEFAULT_USER" -c "pip3 install -r kalibuntu/binaries/metagoofil/requirements.txt >> kalibuntu/kalibuntu.log"
    } >> ../../kalibuntu.log 2>&1
    stop_spinner $?
    echo " "
    echo "Installation finished"
    return
}

uninstall_metagoofil () {
    start_spinner 'Uninstalling metagoofil'
    {
    cd ../.. || exit
    cd binaries || exit
    rm -rf metagoofil
    cd .. || exit
    cd tools/11-reporting_tools || exit
    su - "$DEFAULT_USER" -c "pip3 uninstall google requests -y >> kalibuntu/kalibuntu.log"
    } >> ../../kalibuntu.log 2>&1
    stop_spinner $?
    echo " "
    echo "Uninstallation finished"
    return
}

update_metagoofil () {
    start_spinner 'Updating metagoofil'
    {
    cd ../.. || exit
    cd binaries || exit
    rm -rf metagoofil
    git clone https://github.com/opsdisk/metagoofil.git
    } >> ../../kalibuntu.log 2>&1
    stop_spinner $?
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
    source ../../spinner.sh
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
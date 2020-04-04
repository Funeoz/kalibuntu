#! /usr/bin/env bash

install_dumpzilla () {
    start_spinner 'Installing dependencies'
    su - "$DEFAULT_USER" -c "pip3 install --user python-magic >> kalibuntu/kalibuntu.log 2>&1"
    stop_spinner $?
    echo " "
    start_spinner 'Installing dumpzilla'
    {
    cd ../.. || exit
    cd binaries/ || exit
    mkdir dumpzilla
    cd dumpzilla || exit
    git clone https://github.com/Busindre/dumpzilla.git
    cd ../.. || exit
    cd tools/6-forensics_tools || exit
    } >> ../../kalibuntu.log 2>&1
    stop_spinner $?
    echo " "
    echo "Installation finished"
    echo "Dumpzilla can be found in kalibuntu/binaries"
    return
}

uninstall_dumpzilla () {
    start_spinner 'Removing dumpzilla and dependency'
    su - "$DEFAULT_USER" -c "pip3 uninstall python-magic -y >> kalibuntu/kalibuntu.log 2>&1" 
    cd ../.. || exit
    cd binaries || exit
    rm -rf dumpzilla/
    cd .. || exit
    cd tools/6-forensics_tools || exit
    stop_spinner $?
    echo " "
    echo "Uninstallation finished"
    return
}

return_to_install_script-6 () {
    clear
    ./install_script-6.sh
    return
}

main () {
    clear
    . banner.sh
    tput bold
    echo "Install/Uninstall/Update dumpzilla (updated fork from Busindre/dumpzilla) ?"
    tput sgr0
    echo " "

    select choice in Install Uninstall back; do
        case $choice in 
        Install)
            install_dumpzilla
            break
            ;;
        Uninstall)
            uninstall_dumpzilla
            break
            ;;
        back)
            return_to_install_script-6
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
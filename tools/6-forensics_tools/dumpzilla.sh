#! /usr/bin/env bash

install_dumpzilla () {
    echo "Installing dependencies"
    {
    pip3 install --user python-magic
    } >> ../../kalibuntu.log 2>&1
    echo " "
    echo "Installing dumpzilla..."
    {
    cd ../.. || exit
    cd binaries/ || exit
    mkdir dumpzilla
    cd dumpzilla || exit
    apt-get install git
    git clone https://github.com/Busindre/dumpzilla.git
    } >> ../../kalibuntu.log 2>&1
    echo "Dumpzilla can be found in $(pwd)"
    {
    cd ../.. || exit
    cd tools/6-forensics_tools || exit
    } >> ../../kalibuntu.log 2>&1
    echo " "
    echo "Installation finished"
    return
}

uninstall_dumpzilla () {
    echo "Removing dumpzilla and dependency"
    pip3 uninstall python-magic -y >> ../../kalibuntu.log 2>&1
    cd ../.. || exit
    cd binaries || exit
    rm -rf dumpzilla/
    cd .. || exit
    cd tools/6-forensics_tools || exit
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
    echo "Install/Uninstall/Update dumpzilla (fork from Busindre/dumpzilla) ?"
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
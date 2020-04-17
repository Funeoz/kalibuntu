#! /usr/bin/env bash

install_ghidra () {
    start_spinner 'Installing dependencies'
    apt-get install openjdk-11-jdk openjdk-11-jre-headless -y >> ../../kalibuntu.log 2>&1
    stop_spinner $?
    echo " "
    start_spinner 'Installing ghidra (this can take some time because downloaded from the internet)'
    cd ../.. || exit
    cd binaries/ || exit
    wget https://ghidra-sre.org/ghidra_9.1.2_PUBLIC_20200212.zip
    unzip ghidra_9.1.2_PUBLIC_20200212.zip
    cd ghidra_9.1.2_PUBLIC || exit
    chmod +x ghidraRun
    stop_spinner $?
    echo " "
    echo "Running ghidraRun in kalibuntu/binaries/ghidra_9.1.2_PUBLIC"
    sleep 3
    ./ghidraRun
    cd ../.. || exit
    cd tools/9-reverse_engineering || exit
    return
}

uninstall_ghidra () {
    start_spinner 'Uninstalling dependencies'
    apt-get purge openjdk-11-jdk openjdk-11-jre-headless -y >> ../../kalibuntu.log 2>&1
    cd ../.. || exit
    cd binaries || exit
    rm -rf ghidra_9.1.2_PUBLIC
    stop_spinner $?
    echo " "
    echo "Uninstallation finished"
    return
}


return_to_install_script-9 () {
    clear
    ./install_script-9.sh
    return
}

main () {
    clear
    . banner.sh
    tput bold
    echo "Install/Uninstall ghidra ?"
    tput sgr0
    echo " "

    select choice in Install Uninstall Update back; do
        case $choice in 
        Install)
            install_ghidra
            break
            ;;
        Uninstall)
            uninstall_ghidra
            break
            ;;
        back)
            return_to_install_script-9
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
#! /usr/bin/env bash

install_burpsuite () {
    start_spinner 'Installing dependencies'
    apt-get install openjdk-8-jre -y >> ../../kalibuntu.log 2>&1
    stop_spinner $?
    echo " "
    start_spinner 'Downloading bursuite from official website'
    cd ../.. || exit
    cd binaries || exit
    mkdir burpsuite
    cd burpsuite || exit
    DOWNLOAD_URL="https://portswigger.net/burp/releases/download?product=community&version=2020.2.1&type=Jar"
    curl "${DOWNLOAD_URL}" -q -O  >> ../../kalibuntu.log 2>&1
    cd ../.. || exit
    cd tools/4-web_applications || exit
    echo " "
    echo "Installation finished"
    echo "Burpsuite can be found in kalibuntu/binaries/"
    return
}

uninstall_burpsuite () {
    start_spinner 'Uninstalling dependencies'
    apt-get purge libglib2.0-dev -y >> ../../kalibuntu.log 2>&1
    stop_spinner $?
    start_spinner 'Removing burpsuite'
    cd ../.. || exit
    cd binaries || exit
    rm -rf burpsuite
    cd .. || exit
    cd tools/4-web_applications || exit
    echo " "
    echo "Uninstallation finished"
    return
}

return_to_install_script-4 () {
    clear
    ./install_script-4.sh
    return
}

main () {
    clear
    source ../../spinner.sh
    . banner.sh
    tput bold
    echo "Install/Uninstall burpsuite ?"
    tput sgr0
    echo " "

    select choice in Install Uninstall Update back; do
        case $choice in 
        Install)
            install_burpsuite
            break
            ;;
        Uninstall)
            uninstall_burpsuite
            break
            ;;
        back)
            return_to_install_script-4
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
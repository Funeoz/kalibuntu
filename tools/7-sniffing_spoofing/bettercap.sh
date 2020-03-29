#! /usr/bin/env bash

install_bettercap () {
    echo "Installing dependencies"
    {
    apt-get install libpcap0.8 libusb-1.0-0 libnetfilter-queue1 -y
    } >> ../../kalibuntu.log 2>&1
    echo " "
    echo "Installing bettercap..."
    {
    cd ../.. || exit
    cd binaries/ || exit
    BETTERCAP_VERSION="BETTERCAP_VERSION=$(lastversion https://github.com/bettercap/bettercap 2>&1)"
    echo "$BETTERCAP_VERSION" >> ../tools_version.txt
    lastversion https://github.com/bettercap/bettercap --assets --download --filter linux_amd64
    rm *.sha256
    unzip *.zip
    rm  *.zip
    } >> ../../kalibuntu.log 2>&1
    echo "Installation finished"
    echo "Bettercap can be found in $(pwd)"
    sleep 3
    {
    cd ../.. || exit
    cd tools/7-sniffing_spoofing || exit
    } >> ../../kalibuntu.log 2>&1
    return
}

uninstall_bettercap () {
    echo "Removing bettercap"
    {
    apt-get purge libnetfilter-queue1 -y
    cd ../.. || exit
    cd binaries || exit
    find . -maxdepth 1 -type d -name bettercap\* -delete
    cd .. || exit
    cd tools/7-sniffing_spoofing || exit
    } >> ../../kalibuntu.log 2>&1
    echo " "
    echo "Uninstallation finished"
    return
}


update_bettercap () {
    NEW_BETTERCAP_VERSION="BETTERCAP_VERSION=$(lastversion https://github.com/bettercap/bettercap 2>&1)"
    local NEW_BETTERCAP_VERSION
    
    if [[ $(sed -n '/BETTERCAP_VERSION/p' ../tools_version.txt) != "$NEW_BETTERCAP_VERSION" ]]; then
        {
        sed -i '/BETTERCAP_VERSION/c\BETTERCAP_VERSION=$NEW_BETTERCAP_VERSION' ../tools_version.txt
        cd ../.. || exit
        cd binaries || exit
        find . -maxdepth 1 -type d -name bettercap\* -delete
        lastversion https://github.com/bettercap/bettercap --assets --download --filter linux_amd64
        rm *.sha256
        unzip *.zip
        rm  *.zip
        cd ../.. || exit
        cd tools/7-sniffing_spoofing || exit
        } >> ../../kalibuntu.log 2>&1
        echo " "
        echo "Update finished"
    else 
        echo "You have the latest release installed"
        sleep 1.5
    fi
    return
}

return_to_install_script-7 () {
    clear
    ./install_script-7.sh
    return
}

main () {
    clear
    . banner.sh
    tput bold
    echo "Install/Uninstall/Update bettercap ?"
    tput sgr0
    echo " "

    select choice in Install Uninstall back; do
        case $choice in 
        Install)
            install_bettercap
            break
            ;;
        Uninstall)
            uninstall_bettercap
            break
            ;;
        Update)
            update_bettercap
            break
            ;;
        back)
            return_to_install_script-7
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
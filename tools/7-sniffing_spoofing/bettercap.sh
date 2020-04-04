#! /usr/bin/env bash

get_version () {
    VERSION=$(curl --silent "https://api.github.com/repos/bettercap/bettercap/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')
    echo "BETTERCAP_VERSION=$VERSION" >> ../tools_version.txt
    return
}

install_bettercap () {
    start_spinner 'Installing dependencies'
    apt-get install libpcap0.8 libusb-1.0-0 libnetfilter-queue1 -y >> ../../kalibuntu.log 2>&1
    stop_spinner $?

    get_version

    start_spinner 'Installing bettercap'
    su - "$DEFAULT_USER" -c "{
    cd kalibuntu/binaries && \
    lastversion https://github.com/bettercap/bettercap --assets --download --filter linux_amd64 && \
    rm *.sha256 && \
    unzip *.zip && \
    rm  *.zip *.sha256
    } >> kalibuntu/kalibuntu.log 2>&1"
    stop_spinner $?

    echo " "
    echo "Installation finished"
    echo "Bettercap can be found in /kalibuntu/binaries"
    sleep 3
    return
}

uninstall_bettercap () {
    start_spinner 'Removing bettercap'
    {
    apt-get purge libnetfilter-queue1 -y
    cd ../.. || exit
    cd binaries || exit
    rm bettercap
    cd .. || exit
    cd tools/7-sniffing_spoofing || exit
    } >> ../../kalibuntu.log 2>&1
    stop_spinner $?
    return
}


update_bettercap () {
    NEW_BETTERCAP_VERSION="BETTERCAP_VERSION=$(curl --silent "https://api.github.com/repos/bettercap/bettercap/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')"
    
    if [[ $(sed -n '/BETTERCAP_VERSION/p' ../tools_version.txt) != "$NEW_BETTERCAP_VERSION" ]]; then
        start_spinner 'Updating bettercap'
        {
        sed -i "/BETTERCAP_VERSION/c\\$NEW_BETTERCAP_VERSION" ../tools_version.txt
        cd ../.. || exit
        cd binaries || exit
        rm bettercap
        } >> ../../kalibuntu.log 2>&1
        su - "$DEFAULT_USER" -c "{
        cd kalibuntu/binaries && \
        lastversion https://github.com/bettercap/bettercap --assets --download --filter linux_amd64 && \
        rm *.sha256 && \
        unzip *.zip && \
        rm  *.zip *.sha256
        } >> ../kalibuntu.log 2>&1"
        stop_spinner $?
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
    source ../../spinner.sh
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
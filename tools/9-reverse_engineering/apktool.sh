#! /usr/bin/env bash

get_version () {
    VERSION=$(curl --silent "https://api.github.com/repos/iBotPeaches/Apktool/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')
    echo "APKTOOL_VERSION=$VERSION" >> ../tools_version.txt
    return
}

install_apktool () {
    start_spinner 'Installing dependencies'
    apt-get install openjdk-8-jre -y >> ../../kalibuntu.log 2>&1
    stop_spinner $?
    echo " "

    get_version

    start_spinner 'Installing apktool'
    su - "$DEFAULT_USER" -c "
    cd kalibuntu/binaries && \
    mkdir apktool && \
    cd apktool && \
    lastversion https://github.com/iBotPeaches/Apktool --assets --download --filter apktool >> ../../kalibuntu.log 2>&1"
    stop_spinner $?
    echo " "
    echo "Installation finished"
    echo "apktool can be found in kalibuntu/binaries"
    return
}

uninstall_apktool () {
    start_spinner 'Removing dependencies'
    apt-get purge openjdk-8-jre -y >> ../../kalibuntu.log 2>&1
    stop_spinner $?
    echo " "
    start_spinner 'Removing apktool'
    {
    cd ../.. || exit
    cd binaries || exit
    rm *.jar
    cd .. || exit
    cd tools/9-reverse_engineering || exit
    } >> ../../kalibuntu.log 2>&1
    stop_spinner $?
    return
}

update_apktool () {
    NEW_APKTOOL_VERSION="APKTOOL_VERSION=$(curl --silent "https://api.github.com/repos/iBotPeaches/Apktool/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')"
    
    if [[ $(sed -n '/APKTOOL_VERSION/p' ../tools_version.txt) != "$NEW_APKTOOL_VERSION" ]]; then
    start_spinner 'Updating apktool'
        {
        sed -i "/APKTOOL_VERSION/c\\$NEW_APKTOOL_VERSION" ../tools_version.txt
        cd ../.. || exit
        cd binaries || exit
        rm *.jar
        cd ../.. || exit
        cd tools/7-sniffing_spoofing || exit
        } >> ../../kalibuntu.log 2>&1
        su - "$DEFAULT_USER" -c "
        cd kalibuntu/binaries
        lastversion https://github.com/iBotPeaches/Apktool --assets --download --filter apktool >> ../kalibuntu.log"
        stop_spinner $?
        echo " "
        echo "Update finished"
    else 
        echo "You have the latest release installed"
    fi
    return
}

return_to_install_script-9 () {
    clear
    ./install_script-9.sh
    return
}

main () {
    clear
    source ../../spinner.sh
    . banner.sh
    tput bold
    echo "Install/Uninstall/Update apktool ?"
    tput sgr0
    echo " "

    select choice in Install Uninstall back; do
        case $choice in 
        Install)
            install_apktool
            break
            ;;
        Uninstall)
            uninstall_apktool
            break
            ;;
        Update)
            update_apktool
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
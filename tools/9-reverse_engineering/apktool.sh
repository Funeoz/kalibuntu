#! /usr/bin/env bash

install_apktool () {
    echo "Installing dependencies"
    {
    apt-get install openjdk-8-jre -y
    } >> ../../kalibuntu.log 2>&1
    echo " "
    echo "Installing apktool..."
    {
    cd ../.. || exit
    cd binaries/ || exit
    mkdir apktool
    cd apktool || exit
    APKTOOL_VERSION="APKTOOL_VERSION=$(lastversion https://github.com/iBotPeaches/Apktool 2>&1)"
    echo "$APKTOOL_VERSION" >> ../tools_version.txt
    lastversion https://github.com/iBotPeaches/Apktool --assets --download --filter apktool
    } >> ../../kalibuntu.log 2>&1
    echo "Installation finished"
    echo "apktool can be found in $(pwd)"
    sleep 3
    {
    cd ../.. || exit
    cd tools/9-reverse_engineering || exit
    } >> ../../kalibuntu.log 2>&1
    return
}

uninstall_apktool () {
    echo "Removing dependencies"
    apt-get purge openjdk-8-jre -y >> ../../kalibuntu.log 2>&1
    echo "Removing apktool"
    {
    cd ../.. || exit
    cd binaries || exit
    rm -rf apktool
    cd .. || exit
    cd tools/9-reverse_engineering || exit
    } >> ../../kalibuntu.log 2>&1
    return
}

update_apktool () {
    NEW_APKTOOL_VERSION="APKTOOL_VERSION=$(lastversion https://github.com/iBotPeaches/Apktool 2>&1)"
    local NEW_APKTOOL_VERSION
    
    if [[ $(sed -n '/APKTOOL_VERSION/p' ../tools_version.txt) != "$NEW_APKTOOL_VERSION" ]]; then
        {
        sed -i '/apktool_VERSION/c\apktool_VERSION=$NEW_APKTOOL_VERSION' ../tools_version.txt
        cd ../.. || exit
        cd binaries/apktool || exit
        rm *.jar
        lastversion https://github.com/iBotPeaches/Apktool --assets --download --filter apktool
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

return_to_install_script-9 () {
    clear
    ./install_script-9.sh
    return
}

main () {
    clear
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
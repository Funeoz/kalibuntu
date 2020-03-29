#! /usr/bin/env bash

install_wpcan() {
    echo "Installing dependencies and PPA for latest ubuntu-make package..."
    echo " "
    {
    add-apt-repository ppa:lyzardking/ubuntu-make -y
    apt-get update
    apt-get install ubuntu-make -y
    } >> ../../kalibuntu.log 2>&1
    echo " "
    echo "Installing arduino..."
    umake electronics arduino >> ../../kalibuntu.log 2>&1
    echo " "
    echo "Installation finished"
    return
}

uninstall_arduino () {
    echo "Uninstalling arduino..."
    echo " "
    {
    umake -r arduino
    apt-get purge ubuntu-make -y 
    } >> ../../kalibuntu.log 2>&1
    echo " "
    echo "Removing PPA..."
    add-apt-repository --remove -y ppa:lyzardking/ubuntu-make >> ../../kalibuntu.log 2>&1
    remove_deps
    return
}

remove_deps () {
    echo "Remove dependencies ? (Verify them to prevent broken packages)"
    select yn in yes no; do
        case $yn in 
            yes)
                apt autoremove
                echo " "
                echo "Uninstallation finished"
                break
                ;;
            no) 
                echo " "
                echo "Uninstallation finished"
                break
                ;;
            *)
                clear
                remove_deps
                break
                ;;
        esac
    done
    return
}

update_arduino() {
    {
    umake -r arduino
    umake electronics arduino
    } >> ../../kalibuntu.log 2>&1
    echo " "
    echo "Update finished"
    return
}

return_to_install_script-10 () {
    clear
    ./install_script-10.sh
    return
}

main () {
    clear
    . banner.sh
    tput bold
    echo "Install/Uninstall/Update arduino ?"
    tput sgr0
    echo " "

    select choice in Install Uninstall Update back; do
        case $choice in
            Install) 
                install_arduino
                break
                ;;
            Uninstall) 
                uninstall_arduino
                break
                ;;
            Update)
                update_arduino
                break
                ;;
            back)
                return_to_install_script-10
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
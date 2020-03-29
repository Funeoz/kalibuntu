#! /usr/bin/env bash

install_wireshark () {
    echo "Installing arduino from official PPA..."
    {
    add-apt-repository ppa:wireshark-dev/stable -y
    apt-get update
    apt-get install wireshark -y
    } >> ../../kalibuntu.log 2>&1
    echo " "
    echo "Installation finished"
    return
}

uninstall_wireshark () {
    echo "Removing Wireshark..."
    echo " "
    {
    apt-get purge wireshark -y
    add-apt-repository --remove ppa:wireshark-dev/stable -y
    } >> ../../kalibuntu.log 2>&1
    echo " "
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

update_wireshark () {
    . ../update_deb.sh
    return
}

return_to_install_script-1 () {
    clear
    ./install_script-1.sh
    return
}

main () {
    clear
    . banner.sh
    tput bold
    echo "Install/Uninstall/Update Wireshark ?"
    tput sgr0
    echo " "

    select choice in Install Uninstall Update back; do
        case $choice in
            Install)
                install_wireshark
                break
                ;;
            Uninstall) 
                uninstall_wireshark
                break
                ;;
            Update)
                update_wireshark
                break
                ;;
            back)
                return_to_install_script-1
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
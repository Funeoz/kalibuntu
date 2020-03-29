#! /usr/bin/env bash

install_aircrack-ng () {
    echo "Installing aircrack-ng..."
    apt-get install aircrack-ng -y >> ../../kalibuntu.log 2>&1
    echo " "
    install_airgraph-ng
    return
}

install_airgraph-ng () {
    echo "Install airgraph-ng ? (optional)"
    select yn in yes no; do
        case $yn in 
            yes)
                apt-get install airgraph-ng >> ../../kalibuntu.log 2>&1
                echo " "
                echo "Installation finished"
                break
                ;;
            no) 
                echo " "
                echo "Installation finished"
                break
                ;;
            *)
                clear
                install_airgraph-ng
                break
                ;;
        esac
    done
}

uninstall_aircrack-ng () {
    echo "Removing aircrack-ng and airgraph-ng..."
    apt-get purge aircrack-ng airgraph-ng -y >> ../../kalibuntu.log 2>&1
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

update_aircrack-ng () {
    . ../update_deb.sh
    return
}

return_to_install_script-3 () {
    clear
    ./install_script-3.sh
    return
}

main () {
    clear
    . banner.sh
    tput bold
    echo "Install/Uninstall/Update aircrack-ng ?"
    tput sgr0
    echo " "

    select choice in Install Uninstall Update back; do
        case $choice in 
        Install)
            install_aircrack-ng
            break
            ;;
        Uninstall)
            uninstall_aircrack-ng
            break
            ;;
        Update)
            update_aircrack-ng
            break
            ;;
        back)
            return_to_install_script-3
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
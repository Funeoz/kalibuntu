#! /usr/bin/env bash

install_john () {
    start_spinner 'Installing john'
    apt-get install john -y >> ../../kalibuntu.log 2>&1
    stop_spinner $?
    echo " "
    echo "Installation finished"
    return
}

uninstall_john () {
    start_spinner 'Removing john'
    apt-get purge john -y >> ../../kalibuntu.log 2>&1
    stop_spinner $?
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

update_john () {
    . ../update_deb.sh
    return
}

return_to_install_script-8 () {
    clear
    ./install_script-8.sh
    return
}

main () {
    clear
    source ../../spinner.sh
    . banner.sh
    tput bold
    echo "Install/Uninstall/Update john ?"
    tput sgr0
    echo " "

    select choice in Install Uninstall Update back; do
        case $choice in 
        Install)
            install_john
            break
            ;;
        Uninstall)
            uninstall_john
            break
            ;;
        Update)
            update_john
            break
            ;;
        back)
            return_to_install_script-8
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
#! /usr/bin/env bash

install_pixiewps () {
    start_spinner 'Installing pixiewps'
    apt-get install pixiewps -y >> ../../kalibuntu.log 2>&1
    stop_spinner $?
    echo " "
    echo "Installation finished"
    return
}

uninstall_pixiewps () {
    start_spinner 'Removing pixiewps'
    apt-get purge pixiewps -y >> ../../kalibuntu.log 2>&1
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

update_pixiewps () {
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
    source ../../spinner.sh
    . banner.sh
    tput bold
    echo "Install/Uninstall/Update pixiewps ?"
    tput sgr0
    echo " "

    select choice in Install Uninstall Update back; do
        case $choice in 
        Install)
            install_pixiewps
            break
            ;;
        Uninstall)
            uninstall_pixiewps
            break
            ;;
        Update)
            update_pixiewps
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
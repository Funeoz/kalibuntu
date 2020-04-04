#! /usr/bin/env bash

install_nmap () {
    echo "Do you want to install Zenmap with Nmap?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes)
                start_spinner 'Installing from Ubuntu repositories'
                apt-get install zenmap nmap -y >> ../../kalibuntu.log 2>&1
                stop_spinner $?
                echo " "
                echo "Installation finished"
                break
                ;;
            No) 
                start_spinner 'Installing from Ubuntu repositories'
                apt-get install nmap -y >> ../../kalibuntu.log 2>&1
                stop_spinner $?
                echo " "
                echo "Installation finished"
                break
                ;;
            *)
                clear
                install_nmap
                break
                ;;
        esac
    done
    return
}

uninstall_nmap () {
    start_spinner 'Uninstalling nmap'
    apt-get purge nmap zenmap -y >> ../../kalibuntu.log 2>&1
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

update_nmap () {
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
    source ../../spinner.sh
    . banner.sh
    tput bold
    echo "Install/Uninstall/Update Nmap ?"
    tput sgr0
    echo " "

    select choice in Install Uninstall Update back; do
        case $choice in
            Install) 
                install_nmap
                break
                ;;
            Uninstall) 
                uninstall_nmap
                break
                ;;
            Update)
                update_nmap
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
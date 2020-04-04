#! /usr/bin/env bash

install_wpcan() {
    start_spinner 'Installing dependencies'
    apt-get install build-essential patch ruby-dev zlib1g-dev liblzma-dev ruby2.5 curl rubygems -y >> ../../kalibuntu.log 2>&1
    su - "$DEFAULT_USER" -c "gem install nokigiri >> kalibuntu/kalibuntu.log " 
    stop_spinner $?
    
    start_spinner 'Installing WPscan'
    su - "$DEFAULT_USER" -c "gem install wpscan >> kalibuntu/kalibuntu.log 2>&1"
    stop_spinner $?
    echo " "
    echo "Installation finished"
    return
}

uninstall_wpscan () {
    start_spinner 'Removing WPScan'
    gem uninstall wpscan >> ../../kalibuntu.log 2>&1
    stop_spinner $?
    remove_deps
    return
}

remove_deps () {
    echo "Remove dependencies ? (Verify them to prevent broken packages)"
    select yn in yes no; do
        case $yn in 
            yes)
                su - "$DEFAULT_USER" -c "gem uninstall nokigiri >> kalibuntu/kalibuntu.log 2>&1" 
                apt-get purge build-essential patch ruby-dev zlib1g-dev liblzma-dev ruby2.5 curl rubygems -y ../../kalibuntu.log 2>&1
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

update_wpscan() {
    su - "$DEFAULT_USER" -c "gem update >> kalibuntu/kalibuntu.log 2>&1" 
    echo " "
    echo "Update finished"
    return
}

return_to_install_script-4 () {
    clear
    ./install_script-4.sh
    return
}

main () {
    clear
    source ../../spinner.sh
    . banner.sh
    tput bold
    echo "Install/Uninstall/Update WPScan ?"
    tput sgr0
    echo " "

    select choice in Install Uninstall Update back; do
        case $choice in
            Install) 
                install_wpscan
                break
                ;;
            Uninstall) 
                uninstall_wpscan
                break
                ;;
            Update)
                update_wpscan
                break
                ;;
            back)
                return_to_install_script-4
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
#! /usr/bin/env bash

install_wpcan() {
    echo "Installing dependencies..."
    echo " "
    apt-get install build-essential patch ruby-dev zlib1g-dev liblzma-dev ruby2.5 curl rubygems -y >> ../../kalibuntu.log 2>&1
    gem install nokigiri >> ../../kalibuntu.log 2>&1
    echo " "
    echo "Installing WPScan..."
    gem install wpscan >> ../../kalibuntu.log 2>&1
    echo " "
    echo "Installation finished"
    return
}

uninstall_wpscan () {
    echo "Uninstalling WPScan..."
    echo " "
    gem uninstall wpscan >> ../../kalibuntu.log 2>&1
    remove_deps
    return
}

remove_deps () {
    echo "Remove dependencies ? (Verify them to prevent broken packages)"
    select yn in yes no; do
        case $yn in 
            yes)
                gem uninstall nokigiri 
                apt-get purge build-essential patch ruby-dev zlib1g-dev liblzma-dev ruby2.5 curl rubygems
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
    gem update
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
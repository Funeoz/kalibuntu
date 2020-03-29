#! /usr/bin/env bash

install_hydra () {
    echo "Installing hydra..."
    apt-get install hydra -y >> ../../kalibuntu.log 2>&1
    return
}

uninstall_hydra () {
    echo "Removing hydra..."
    apt-get purge hydra -y >> ../../kalibuntu.log 2>&1
    remove_deps
    return
}

remove_deps () {
    echo "Remove dependencies ? (Verify them to prevent broken packages)"
    select yn in yes no; do
        case $yn in 
            yes)
                apt autoremove
                break
                ;;
            no) 
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

update_hydra () {
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
    . banner.sh
    tput bold
    echo "Install/Uninstall/Update hydra ?"
    tput sgr0
    echo " "

    select choice in Install Uninstall Update back; do
        case $choice in 
        Install)
            install_hydra
            break
            ;;
        Uninstall)
            uninstall_hydra
            break
            ;;
        Update)
            update_hydra
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
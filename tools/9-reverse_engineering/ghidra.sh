#! /usr/bin/env bash

# install_ghidra () {
#     echo "Installing dependencies..."
#     apt-get update
#     apt-get install openjdk-11-jdk
#     apt-get install openjdk-11-jre-headless
#     echo " "
#     echo "Installing ghidra"
#     cd ../.. || exit
#     cd binaries/ || exit
#     GHIDRA_VERSION="GHIDRA_VERSION=$(lastversion https://github.com/NationalSecurityAgency/ghidra 2>&1)"
#     echo "$GHIDRA_VERSION" >> ../tools_version.txt
#     lastversion https://github.com/NationalSecurityAgency/ghidra --assets --download
#     tar xvzf .tar.gz
    
#     clear
#     echo "Installation finished"
#     echo "ghidra can be found in $(pwd)"
#     sleep 3
#     cd ../.. || exit
#     cd tools/9-reverse_engineering || exit

#     return
# }

# uninstall_ghidra () {
#     pip3 uninstall ghidra
#     echo " "
#     echo "Uninstallation finished"
#     return
# }

# update_ghidra () {
#     pip3 install --upgrade ghidra
#     echo " "
#     echo "Upgrade finished"
#     return
# }

# return_to_install_script-2 () {
#     clear
#     ./install_script-2.sh
#     return
# }

# main () {
#     clear
#     . banner.sh
#     tput bold
#     echo "Install/Uninstall/Update ghidra ?"
#     tput sgr0
#     echo " "

#     select choice in Install Uninstall Update back; do
#         case $choice in 
#         Install)
#             install_ghidra
#             break
#             ;;
#         Uninstall)
#             uninstall_ghidra
#             break
#             ;;
#         Update)
#             update_ghidra
#             break
#             ;;
#         back)
#             return_to_install_script-2
#             break
#             ;;
#         *)
#             clear
#             main
#             break
#             ;;
#         esac
#     done
#     return
# }

# main
if [ "$EUID" -ne 0 ]; then
    printf "$BBLUE[i]$OFF |$BLUE This script needs to be run as root. Attempting to elevate...$OFF\n"
    sudo "bash" "$0" "$@"  
    exit $?
fi


echo "[ ########## WARNING! PLEASE READ!!! ########## ]"
echo "THIS ONLY WORKS ON DEBIAN/UBUNTU CONTAINERS -----"
echo "IF YOU ARENT IN ONE SWITCH TO ONE OR PRESS CTRL+C"
echo "Waiting 3 seconds..."
sleep 3

# Install SNAP
sudo apt -y update
sudo apt -y install snapd
sudo snap install core
sudo snap install snap-store

# Install Flatpak
sudo apt -y install flatpak
sudo apt -y install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

clear 
echo "Snap and Flatpak have been installed successfully."
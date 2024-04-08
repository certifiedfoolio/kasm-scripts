if [ "$EUID" -ne 0 ]; then
    printf "$BBLUE[i]$OFF |$BLUE This script needs to be run as root. Attempting to elevate...$OFF\n"
    sudo "bash" "$0" "$@"  
    exit $?
fi

DEBIAN_FRONTEND=noninteractive

echo "[ ########## WARNING! PLEASE READ!!! ########## ]"
echo "THIS ONLY WORKS ON DEBIAN-BASED/FEDORA-BASED CONTAINERS! -----"
echo "IF YOU ARENT IN ONE SWITCH TO ONE OR PRESS CTRL+C"
echo "Waiting 3 seconds..."
sleep 3

echo "Detecting container..."
which dnf >/dev/null && { DISTRO="FEDORA"; exit 0; }
which apt-get >/dev/null && { DISTRO="DEBIAN"; }
if [ "$DISTRO" == "DEBIAN" ]; then PKGMGR="apt"
fi
if [ "$DISTRO" == "FEDORA" ]; then PKGMGR="dnf"
fi

# Install SNAP
sudo $PKGMGR -y update
sudo $PKGMGR -y install snapd
sudo snap install core
sudo snap install snap-store

# Install Flatpak
sudo $PKGMGR -y install flatpak
sudo $PKGMGR -y install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

clear 
echo "Snap and Flatpak have been installed successfully."

# Reset
OFF='\033[0m'       # Text Reset

# Regular Colors
BLACK='\033[0;30m'        # BLACK
RED='\033[0;31m'          # RED
GREEN='\033[0;32m'        # GREEN
YELLOW='\033[0;33m'       # YELLOW
BLUE='\033[0;34m'         # BLUE
PURPLE='\033[0;35m'       # PURPLE
CYAN='\033[0;36m'         # CYAN
WHITE='\033[0;37m'        # WHITE

# Bold
BBLACK='\033[1;30m'       # BLACK
BRED='\033[1;31m'         # RED
BGREEN='\033[1;32m'       # GREEN
BYELLOW='\033[1;33m'      # YELLOW
BBLUE='\033[1;34m'        # BLUE
BPURPLE='\033[1;35m'      # PURPLE
BCYAN='\033[1;36m'        # CYAN
BWHITE='\033[1;37m'       # WHITE

# Underline
UBLACK='\033[4;30m'       # BLACK
URED='\033[4;31m'         # RED
UGREEN='\033[4;32m'       # GREEN
UYELLOW='\033[4;33m'      # YELLOW
UBLUE='\033[4;34m'        # BLUE
UPURPLE='\033[4;35m'      # PURPLE
UCYAN='\033[4;36m'        # CYAN
UWHITE='\033[4;37m'       # WHITE

# Background
On_BLACK='\033[40m'       # BLACK
On_RED='\033[41m'         # RED
On_GREEN='\033[42m'       # GREEN
On_YELLOW='\033[43m'      # YELLOW
On_BLUE='\033[44m'        # BLUE
On_PURPLE='\033[45m'      # PURPLE
On_CYAN='\033[46m'        # CYAN
On_WHITE='\033[47m'       # WHITE

if [ "$EUID" -ne 0 ]; then
    printf "$BBLUE[i]$OFF |$BLUE This script needs to be run as root. Attempting to elevate...$OFF\n"
    sudo "bash" "$0" "$@"  
    exit $?
fi

get_distro() {
OS=$( ( lsb_release -ds || cat /etc/*release || uname -om ) 2>/dev/null | head -n1)
}

apt_inst() {
curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
sudo apt-get update > /dev/null && sudo apt-get -y install cloudflare-warp
printf "$BBLUE[i]$OFF |$BLUE Successfully installed... Connecting to WARP.$OFF\n"
sleep 1
connect
}

ubuntu_inst() {
printf "$BBLUE[i]$OFF |$BLUE Installing for Ubuntu...$OFF\n"
apt_inst

}

debian_inst() {
printf "$BBLUE[i]$OFF |$BLUE Installing for Debian...$OFF\n"
apt_inst
}

other_inst() {
printf "$BBLUE[i]$OFF |$BLUE Installing for $( ( lsb_release -ds || cat /etc/*release || uname -om ) 2>/dev/null | head -n1)...$OFF\n"
apt_inst
}

connect() {
warp-cli --accept-tos registration new > /dev/null 
warp-cli --accept-tos mode warp+doh > /dev/null 
warp-cli --accept-tos connect
}

echo "Select your distro:"
echo "1. Debian"
echo "2. Ubuntu"
echo "3. Other distro that supports APT"
echo ""
echo "8. Connect only (use warp-cli connect instead)"
echo "9. Disconnect (use warp-cli disconnect instead)"
printf "$BBLUE"
printf "TIP:$BLUE Pressing any other key exits.$OFF\n"

read -sn1 distro
case "$distro" in
    1) debian_inst ;;
    2) ubuntu_inst ;;
    3) other_inst ;;
    8) connect ;;
    9) warp-cli --accept-tos disconnect ;;
    *) printf "$BRED[!] $OFF|$RED Invalid input. Exiting.\n" && exit 1 ;;
esac


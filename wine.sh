echo "[ ########## WARNING! PLEASE READ!!! ########## ]"
echo "THIS ONLY WORKS ON DEBIAN/UBUNTU CONTAINERS -----"
echo "IF YOU ARENT IN ONE SWITCH TO ONE OR PRESS CTRL+C"
echo "Waiting 3 seconds..."
sleep 3

DEBIAN_FRONTEND=noninteractive
sudo apt update
sudo apt -y install wine

echo "wine is installed. you could of done:"
echo "sudo apt -y install wine"
echo "you lazy ass"
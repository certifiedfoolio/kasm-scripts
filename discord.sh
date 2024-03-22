echo "[ ########## WARNING! PLEASE READ!!! ########## ]"
echo "THIS ONLY WORKS ON DEBIAN/UBUNTU CONTAINERS -----"
echo "IF YOU ARENT IN ONE SWITCH TO ONE OR PRESS CTRL+C"
echo "Waiting 3 seconds..."
sleep 3

DEBIAN_FRONTEND=noninteractive

curl -fsSL https://apt.armcord.app/public.gpg | sudo gpg --dearmor -o /usr/share/keyrings/armcord.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/armcord.gpg] https://apt.armcord.app/ stable main" | sudo tee /etc/apt/sources.list.d/armcord.list
sudo apt update > /dev/null
sudo apt install -y armcord
echo "\n\n"
echo "Run armcord to start ArmCord (discord)"
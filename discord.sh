# This installs the AppImage version to be universally compatible
wget https://github.com/ArmCord/ArmCord/releases/download/v3.2.6/ArmCord-3.2.6.AppImage > /dev/null 2> /dev/null 
chmod +x ArmCord-3.2.6.AppImage
mv ArmCord-3.2.6.AppImage armcord.AppImage
echo "ArmCord has been downloaded in your current working directory."
echo "Run ./armcord.AppImage to run ArmCord (Discord)"
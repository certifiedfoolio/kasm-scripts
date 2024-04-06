#!/bin/bash

DIR="/kasm-scripts"

clear

dialog --menu "Welcome to Ease of Setup! Please choose an option:" 20 60 5 \
    --backtitle "Ease of Setup" \
    1 "Install App Managers" \
    2 "Install Yandere Sim"
    3 "Install Minecraft" \
    4 "Install Discord" \
    5 "Install Java" \
    6 "Install Wine" \
    7 "Purge /tmp/*" \
    8 "View Temp" 2>$TMPFILE

RESULT=$(cat $TMPFILE)

case $RESULT in
    1) sudo bash $DIR/appstore.sh;;
    2) sudo bash $DIR/yandere_simulator.sh;;
    3) sudo bash $DIR/minecraft.sh;;
    4) sudo bash $DIR/discord.sh;;
    5) sudo bash $DIR/installjava.sh;;
    6) sudo bash $DIR/wine.sh;;
    7) sudo rm -rf /tmp/*;;
    8) sudo bash $DIR/tmpfile.sh
    *) echo "Setup has quit." && echo "If you wish to run setup again, please run 'bash /menu.sh'.";;
esac
#!/bin/sh

eips 1 1 "Installing Kterm..."
curl -L -o /mnt/us/KiViStore/icons/kterm.png https://raw.githubusercontent.com/VladiGuive/KIcons/refs/heads/main/kterm.png
curl -L -o /mnt/us/KiViStore/tmp/kterm-kindle-2.6-armhf.zip https://github.com/bfabiszewski/kterm/releases/download/v2.6/kterm-kindle-2.6-armhf.zip
unzip -o /mnt/us/KiViStore/tmp/kterm-kindle-2.6-armhf.zip -d /mnt/us/KiViStore/tmp/
mv /mnt/us/KiViStore/tmp/kterm /mnt/us/extensions/kterm
rm -rf /mnt/us/KiViStore/tmp/kterm-kindle-2.6-armhf.zip /mnt/us/KiViStore/tmp/kterm

cat > /mnt/us/documents/kterm.sh <<- EOM
#!/bin/sh
# Name: Kterm 
# DontUseFBInk
# Icon: /mnt/us/KiViStore/icons/kterm.png
bash /mnt/us/extensions/kterm/bin/kterm.sh
EOM
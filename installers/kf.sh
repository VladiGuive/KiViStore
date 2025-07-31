#!/bin/sh

eips 1 1 "Installing KindleFetch..."
curl -L -o /mnt/us/KiViStore/icons/kindlefetch.png https://raw.githubusercontent.com/VladiGuive/KIcons/refs/heads/main/KindleFetch.png
curl https://justrals.github.io/KindleFetch/install.sh | sh

cat > /mnt/us/documents/Kindlefetch.sh <<- EOM
#!/bin/sh
# Name: KindleFetch
# DontUseFBInk
# Icon: /mnt/us/KiViStore/icons/kindlefetch.png
bash /mnt/us/extensions/kindlefetch/run.sh
EOM
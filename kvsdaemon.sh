#!/bin/sh

PORT=1122
rm -f /mnt/us/KiViStore/tmp/request.txt /mnt/us/KiViStore/tmp/response.txt
touch /mnt/us/KiViStore/tmp/request.txt
touch /mnt/us/KiViStore/tmp/response.txt
while true; do
  echo "Awaiting on $PORT..."
  (
    nc -l -p "$PORT" > /mnt/us/KiViStore/tmp/request.txt < /mnt/us/KiViStore/tmp/response.txt &
    NC_PID=$!
    wait $NC_PID
    cat /mnt/us/KiViStore/tmp/request.txt
    LINE=$(head -n 1 /mnt/us/KiViStore/tmp/request.txt 2>/dev/null)

    if echo "$LINE" | grep -q "^GET /?kill"; then
      echo "Killing KiViStore..."
      reboot
    fi
    
    SAFE_NAME=$(echo "$LINE" | sed -n 's/^GET \/?.*name=\([^ &]*\).*/\1/p')

    if [ -n "$SAFE_NAME" ]; then
      echo -e "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nInstalling, wait untill restart..." > /mnt/us/KiViStore/tmp/response.txt
      bash /mnt/us/KiViStore/installers/$SAFE_NAME.sh
      sleep 5
      reboot
    fi

   
  )
done

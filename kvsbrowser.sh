#!/bin/bash

## From KOReader, modified for KiViStore
if [ -d /etc/upstart ]; then
    export INIT_TYPE="upstart"
    if [ -f /etc/upstart/functions ]; then
        . /etc/upstart/functions
    fi
else
    export INIT_TYPE="sysv"
    if [ -f /etc/rc.d/functions ]; then
        . /etc/rc.d/functions
    fi
fi

# From Shorcut Browser, modified for KiViStore
if [ "${INIT_TYPE}" = "sysv" ]; then
    /etc/init.d/framework stop
else
    trap "" TERM
    stop lab126_gui
    usleep 1250000
    trap - TERM
fi

eips -c &> /dev/null
eips -c &> /dev/null

export XDG_CONFIG_HOME="/mnt/us/system/browser/"
export LD_LIBRARY_PATH="/usr/bin/chromium/lib:/usr/bin/chromium/usr/lib:/usr/lib/"


/usr/bin/chromium/bin/kindle_browser "file:///mnt/us/KiViStore/index.html" --no-zygote --no-sandbox --single-process \
--skia-resource-cache-limit-mb=64 --disable-gpu --in-process-gpu --disable-gpu-sandbox \
--disable-gpu-compositing --enable-dom-distiller --enable-distillability-service \
--force-device-scale-factor=2 --js-flags=jitless --content-shell-hide-toolbar  \
--content-shell-host-window-cord=0,215 --force-gpu-mem-available-mb=32 --enable-grayscale-mode \
--enable-low-end-device-mode --enable-low-res-tiling --disable-site-isolation-trials \
--user-agent="Mozilla/5.0 (X11; U; Linux armv7l like Android; en-us) AppleWebKit/531.2+ (KHTML, like Gecko) Version/5.0 Safari/533.2+ Kindle/3.0+" &
unset LD_LIBRARY_PATH
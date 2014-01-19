#!/bin/bash
#based on https://wiki.archlinux.org/index.php/Chromium
 
if [ `uname -m` == 'x86_64' ]; then
  # 64-bit
  export CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
#  export TALK="https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb"
#  export JAVA="http://javadl.sun.com/webapps/download/AutoDL?BundleId=65687"
else
  # 32-bit
  export CHROME="https://dl-ssl.google.com/linux/direct/google-chrome-stable_current_i386.deb"
#  export TALK="https://dl.google.com/linux/direct/google-talkplugin_current_i386.deb"
#  export JAVA="http://javadl.sun.com/webapps/download/AutoDL?BundleId=65685"
fi
 
 
#clean stuff
mount -o remount, rw /
cd /opt/
rm "/opt/deb2tar.py"
 
curl -o "/opt/deb2tar.py" "https://gist.github.com/dz0ny/3065781/raw/398f54a2b89e63396f9fb32d73384d6537aa32b8/deb2tar.py"
 
mkdir -p /usr/lib/mozilla/plugins/
 
#Flash, pdf
 
echo "Downloading Google Chrome"
curl -z "/opt/chrome-bin.deb" -o "/opt/chrome-bin.deb" -L $CHROME

rename /opt/data.tar.lzma /opt/chrome.tar.lzma

python /opt/deb2tar.py /opt/chrome-bin.deb /opt/chrome.tar.lzma

rm -rf chrome-unstable
mkdir chrome-unstable
tar -xvf /opt/chrome.tar.lzma -C chrome-unstable
 
#flash
cp /opt/chrome-unstable/opt/google/chrome/PepperFlash/libpepflashplayer.so /opt/google/chrome/PepperFlash/ -f
cp /opt/chrome-unstable/opt/google/chrome/PepperFlash/manifest.json /opt/google/chrome/PepperFlash/ -f
curl -L https://raw.github.com/gist/3065781/pepper-flash.info > /opt/google/chrome/PepperFlash/pepper-flash.info
 
rm -rf chrome-unstable
rm /opt/chrome.tar.lzma
 
env-update
#restart ui

#/bin/sh
if [ -e /dev/video0 ]; then
  echo "This script have to add sudo"
  sudo chmod a+rw /dev/video0
  echo "Enable camera (/dev/video0)"
else
  echo "/dev/video0 not found"
fi


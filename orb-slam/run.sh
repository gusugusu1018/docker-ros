#!bin/sh
# image minaki/orb-slam:base
echo "docker run -it --rm \
  --net rosnet \
  --device=/dev/video0 \
  --name master \
  --env ROS_HOSTNAME=master \
  --env ROS_MASTER_URI=http://master:11311 \
  --env DISPLAY=unix$DISPLAY \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  orb-slam:base \
  /bin/bash"
docker run -it --rm \
  --net rosnet \
  --device=/dev/video0 \
  --name master \
  --env ROS_HOSTNAME=master \
  --env ROS_MASTER_URI=http://master:11311 \
  --env DISPLAY=unix$DISPLAY \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  minaki/orb-slam:base  \
  /bin/bash



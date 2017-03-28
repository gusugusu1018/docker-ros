#!bin/sh
# image minaki/orb-slam:full
docker run -it --rm minaki/orb-slam:full --net rosnet --name master --env ROS_HOSTNAME=master --env ROS_MASTER_URI=http://master:11311 --env DISPLAY=unix$DISPLAY --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" zsh

echo "docker run -it --rm orb-slam:core --net rosnet --name master --env ROS_HOSTNAME=master --env ROS_MASTER_URI=http://master:11311 --env DISPLAY=unix$DISPLAY --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" bash"


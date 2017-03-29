#bin/sh
# $1=image
docker run -it --rm --net rosnet --name master --env ROS_HOSTNAME=master --env ROS_MASTER_URI=http://master:11311 --env DISPLAY=unix$DISPLAY --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" $1 /bin/bash

echo "docker run -it --rm --net rosnet --name master --env ROS_HOSTNAME=master --env ROS_MASTER_URI=http://master:11311 --env DISPLAY=unix$DISPLAY --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" $1 /bin/bash"

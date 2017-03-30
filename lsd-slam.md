# DockerでLSD-SLAMしたい
[CHItAさんのgithub repository](https://github.com/CHItA/ros-docker)を使ってやってみる。

## LSD-SLAM用のイメージののbuild
```
git clone https://github.com/CHItA/ros-docker.git
cd ros-docker/images/ros-indigo
sudo docker pull ubuntu:trusty
sudo docker build --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) --build-arg USERNAME=${USER} -t ros-indigo:latest .
```

しかし、エラー
```
gpg: requesting key B01FA116 from hkp server ha.pool.sks-keyservers.net
gpg: keyserver timed out
gpg: keyserver receive failed: keyserver error
```
セキュリティーの関係か、違うネットワークに属す、違うPCでは実行できた。  
このbuildではpureなubuntu:trustyからすべて環境構築をしているので、とても長い。  

buildができると、このイメージはros-indigo:latestとなるが、これをros-indigo-chita:latestと直したいときは以下のようにする。  
```
sudo docker tag ros-indigo:latest ros-indigo-chita:latest
sudo docker rmi ros-indigo
sudo docker images
```
## LSD-SLAMイメージののbuild
次に、LSD-SLAM用のimageを作成する。
```
cd ../lsd-slam/
sudo docker build -t lsd-slam:latest .
```
先ほど作成したros-indigoのイメージをros-indigo-chitaにした場合は、DockerfileのFROMも書き直す必要がある。  

## LSD-SLAMのサンプルデータを再生
docker runさせ、
```
sudo docker run -ti --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix lsd-slam /bin/bash
```
roscoreし、rosrunできれば成功のはずだが、、、
```
roscore > /dev/null &
rosrun lsd_slam_viewer viewer
```

たしかに、Docker上のROSからGUI画面が出た！！  
これだけだと、画面が出るだけなので、viewerもバックグラウンド実行させ、slam_coreもバックグラウンド実行させ、rosbagでデータを再生してみた。

```
sudo apt update
sudo apt install wget## LSD-SLAMイメージののbuild
cd
wget http://vmcremers8.informatik.tu-muenchen.de/lsd/LSD_room.bag.zip
roscore > /dev/null &
rosrun lsd_slam_viewer viewer &
rosrun lsd_slam_core live_slam image:=/image_raw camera_info:=/camera_info &
rosbag play ~/LSD_room.bag
```

## lsd_slam_core
```
sudo docker run -it --rm --net rosnet --name master --env ROS_HOSTNAME=master --env ROS_MASTER_URI=http://master:11311 --env DISPLAY=unix$DISPLAY --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" --device=/dev/video0 lsd-slam bash
sudo apt update
sudo apt install ros-indigo-camera-umd tmux
roscore
rosrun lsd_slam_viewer viewer
rosrun uvc_camera uvc_camera_node 
rosrun lsd_slam_core live_slam /image:=/image_raw /camera_info:=/camera_info
```
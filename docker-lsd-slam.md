# dockerでlsd-slamしたい
[CHItAさんのgithub repository](https://github.com/CHItA/ros-docker)を使ってやってみる。

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

次に、lsd-slam用のimageを作成する。
```
cd ../lsd-slam/
sudo docker build -t lsd-slam:latest .
```
先ほど作成したros-indigoのイメージをros-indigo-chitaにした場合は、DockerfileのFROMも書き直す必要がある。  

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
しかし、なにも映らない。
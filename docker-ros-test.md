# docker rosあまりよくない方法
以下試してみてもいいが、結構コマンドがめんどい。    
## docker run roscore
```
sudo docker run -h master -it --rm --name master --env ROS_HOSTNAME=master osrf/ros:indigo-desktop-full roscore
```

別のコンテナにネットワーク上の位置を教える必要がある。  
```
--add-host=""    : Add a line to /etc/hosts (host:IP)
```

ipがわからなかったので、一度bashを開いて、ifconfigしてから、roscoreする。  
docker inspectしてもよい。

```
sudo docker run -h master -it --rm --name master --env ROS_HOSTNAME=master osrf/ros:indigo-desktop-full  
ifconfig  
roscore  
```
## docker run talker
```
sudo docker run  --add-host="master:masterのIPアドレス" -h talker -it --rm --name talker --env ROS_HOSTNAME=talker --env ROS_MASTER_URI=http://master:11311 osrf/ros:indigo-desktop-full talker
```
## docker run listener
```
sudo docker run -it -h listener --add-host="master:masterのIPアドレス" --add-host="talker:talkerのIPアドレス" --rm --name listener --env ROS_HOSTNAME=listener --env ROS_MASTER_URI=http://master:11311 osrf/ros:indigo-desktop-full listener
```
talkerとlistenerも同様にやるが、このようなやり方だと少し苦労する。  

# docker network create rosnet
こちらの方法だとネットワーク周りが少し楽にできる。  
## Dockerfileを書く
まず、tutorial用のDockerfileをつくって、buildする。  

Dockerfileをテストのディレクトリに置く。  
```
FROM ros:indigo
# install ris tutorials packages
RUN apt-get update && apt-get install -y
RUN apt-get install -y ros-indigo-ros-tutorials ros-indigo-common-tutorials && rm -rf /var/lib/opt/lists
```
## docker build
ディレクトリ内でdocker build
```
sudo docker build -t ros:ros-tutorials .
```

-tはtagのtで、rosリポジトリのros-tutorialsというタグのイメージができる。  
```
sudo docker images
```
## create rosnet
次に、rosnetを作成する。
```
sudo docker network create rosnet
```
docker runでは--net rosnetのようにすると、コンテナを同じネットワークに入れることができる。いちいちifconfigみたいにしなくてもよい。  
## docker run roscore
まず、roscoreを実行  
```
sudo docker run -it --rm --net rosnet --name master ros:ros-tutorials roscore 
```
## docker run talker
次に、talkerを実行  
```
sudo docker run -it --rm --net rosnet --name talker ros:ros-tutorials --env ROS_HOSTNAME=talker --env ROS_MASTER_URI=http://master:11311 rostutorials rosrun roscpp-tutorials talker
```
## docker run listener
最後にlistenerを実行
```
sudo docker run -it --rm --net rosnet --name listener ros:ros-tutorials --env ROS_HOSTNAME=listener --env ROS_MASTER_URI=http://master:11311 rostutorials rosrun roscpp-tutorials listener
```


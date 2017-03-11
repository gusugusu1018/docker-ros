# docker rosあまりよくない方法
以下試してみてもいいが、結構コマンドがめんどい。    
## docker run roscore
```
sudo docker run -h master -it --rm --name master --env ROS_HOSTNAME=master osrf/ros:indigo-desktop-full roscore
```

これだとipがわからなかったので、一度bashを開いて、ifconfigしてから、roscoreする。
```
sudo docker run -h master -it --rm --name master --env ROS_HOSTNAME=master osrf/ros:indigo-desktop-full  
ifconfig  
roscore  
```
talkerとlistenerも同様にやるが、このようなやり方だと少し苦労する。  

# docker network create rosnet
こちらの方法だとネットワーク周りが少し楽にできる。  
まず、tutorial用のDockerfileをつくって、buildする。  

Dockerfileをテストのディレクトリに置く。  
```
FROM ros:indigo
# install ris tutorials packages
RUN apt-get update && apt-get install -y
RUN apt-get install -y ros-indigo-ros-tutorials ros-indigo-common-tutorials && rm -rf /var/lib/opt/lists
```
ディレクトリ内でdocker build
```
sudo docker build -t ros:ros-tutorials .
```

-tはtagのtで、rosリポジトリのros-tutorialsというタグのイメージができる。  
```
sudo docker images
```
次に、rosnetを作成する。
```
sudo docker network create rosnet
```
docker runでは--net rosnetのようにすると、コンテナを同じネットワークに入れることができる。いちいちifconfigみたいにしなくてもよい。  

まず、roscoreを実行  
```
sudo docker run -it --rm --net rosnet --name master ros:ros-tutorials roscore 
```

次に、talkerを実行  
```
sudo docker run -it --rm --net rosnet --name talker ros:ros-tutorials --env ROS_HOSTNAME=talker --env ROS_MASTER_URI=http://master:11311 rostutorials rosrun roscpp-tutorials talker
```

最後にlistenerを実行
```
sudo docker run -it --rm --net rosnet --name listener ros:ros-tutorials --env ROS_HOSTNAME=listener --env ROS_MASTER_URI=http://master:11311 rostutorials rosrun roscpp-tutorials listener
```


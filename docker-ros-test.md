# docker rosあまりよくない方法
以下試してみてもいいが、結構コマンドがめんどい。    
## docker run roscore
```
sudo docker run -h master -it --rm --name master --env ROS_HOSTNAME=master osrf/ros:indigo-desktop-full roscore
```

```
sudo docker run -h master -it --rm --name master --env ROS_HOSTNAME=master osrf/ros:indigo-desktop-full  
ifconfig  
roscore  
```

## talker
```
sudo docker run  --add-host="master:masterのIPアドレス" -h talker -it --rm --name talker --env ROS_HOSTNAME=talker --env ROS_MASTER_URI=http://master:11311 osrf/ros:indigo-desktop-full talker  
```

```
sudo docker run  --add-host="master:master address" -h talker -it --rm --name talker --env ROS_HOSTNAME=talker --env ROS_MASTER_URI=http://master:11311 osrf/ros:indigo-desktop-full  
ifconfig  
talker
```

## listener
```
sudo docker run -it -h listener --add-host="master:masterのIPアドレス" --add-host="talker:talkerのIPアドレス" --rm --name listener --env ROS_HOSTNAME=listener --env ROS_MASTER_URI=http://master:11311 osrf/ros:indigo-desktop-full listener
```

```
sudo docker run -it -h listener --add-host="master:master address" --add-host="talker:talker address" --rm --name listener --env ROS_HOSTNAME=listener --env ROS_MASTER_URI=http://master:11311 osrf/ros:indigo-desktop-full  
ifconfig  
listener  
```

ROSは内部でネットワークが必要になる。  
よってこのようなやり方だと少し苦労する。  
# docker x ros test
    1. docker rosあまりよくない方法
    2. docker network create rosnet
    3. docker with tmux
    4. rviz
    5. docker commit ros with tmux image
    6. camera

#1. docker rosあまりよくない方法  
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

#2. docker network create rosnet
    こちらの方法だとネットワーク周りが少し楽にできる。  
    ## Dockerfileを書く
    まず、tutorial用のDockerfileをつくって、buildする。  

    Dockerfileをテストのディレクトリに置く。  
    ```
    FROM osrf/ros:indigo-desktop-full
    # install ros tutorials packages
    RUN apt-get update && apt-get install -y \
      ros-indigo-ros-tutorialsi \
      ros-indigo-common-tutorials \
      && rm -rf /var/lib/opt/lists
    ```
    ## docker build
    ディレクトリ内でdocker build
    ```
    sudo docker build -t minaki/ros:ros-tutorials .
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
    sudo docker run -it --rm --net rosnet --name master minaki/ros:ros-tutorials roscore 
    ```
    ## docker run talker
    次に、talkerを実行  
    ```
    sudo docker run -it --rm --net rosnet --name talker minaki/ros:ros-tutorials --env ROS_HOSTNAME=talker --env ROS_MASTER_URI=http://master:11311 rostutorials rosrun roscpp-tutorials talker
    ```
    ## docker run listener
    最後にlistenerを実行
    ```
    sudo docker run -it --rm --net rosnet --name listener minaki/ros:ros-tutorials --env ROS_HOSTNAME=listener --env ROS_MASTER_URI=http://master:11311 rostutorials rosrun roscpp-tutorials listener
    ```
#3. docker with tmux
  * terminal multiprexerを使って一つのコンテナで複数のプロセスを実行させる。
    ```
    sudo docker run -it --rm ros:ros-tutorials
    apt update
    apt install -y tmux
    tmux
    # C-b % # virtual split
    # C-b " # split
    # C-b q 0 or 1 or 2# move to any pain
    roscore
    rosrun roscpp_tutorials listener
    rosrun roscpp_tutorials talker
    ```

#4. rviz
  * Rvizを実行をしてみる。
    ```
    sudo docker network create rosnet
    sudo docker run -it --rm --net rosnet --name master --env ROS_HOSTNAME=master osrf/ros:indigo-desktop-full roscore
    xhost +
    # clients can connect from any host
    sudo docker run -it --rm --net rosnet --name rviz --env ROS_HOSTNAME=rviz --env ROS_MASTER_URI=http://master:11311 --env DISPLAY=unix$DISPLAY --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" osrf/ros:indigo-desktop-full rosrun rviz rviz
    ```

#5. docker commit ros with tmux image
  * how to docker commit
    ```
    sudo docker run -it --name with-tmux osrf/ros:indigo-desktop-full bash
    apt update 
    apt install tmux
    exit
    sudo docker ps -a
    sudo docker commit with-tmux osrf/ros:withtmux
    sudo docker images
    ```
  * turtlesimを走らせてみる
    turtlesim test
    ```
    sudo docker run -it --rm --net rosnet --name master --env ROS_HOSTNAME=master --env ROS_MASTER_URI=http://master:11311 --env DISPLAY=unix$DISPLAY --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" osrf/ros:withtmux bash
    tmux
    # C-b % # virtual split
    # C-b " # split
    # C-b q 0 or 1 or 2# move to any pain
    roscore
    # move to other pain
    rosrun turtlesim turtlesim_node
    # move to pain
    rosrun turtlesim turtle_teleop_key
    ```

#6. camera
  * usb deviceをdocker上で使ってみる。
    ```
    sudo chmod a+rw /dev/video0
    sudo docker run -it --rm --net rosnet --name master --env ROS_HOSTNAME=master --env ROS_MASTER_URI=http://master:11311 --env DISPLAY=unix$DISPLAY --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" --device=/dev/video0 osrf/ros:withtmux bash
    apt install ros-indigo-camera-umd
    tmux
    # C-b % # virtual split
    # C-b " # split
    # C-b q 0 or 1 or 2# move to any pain
    roscore
    # move to other pain
    rosrun uvc_camera uvc_camera_node
    # move to pain
    rosrun image_view image_view image:=/image_raw
    ```

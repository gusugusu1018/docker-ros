# docker test
    1. docker rosあまりよくない方法
    2. docker network create rosnet
    3. docker with tmux
    4. rviz

1. docker rosあまりよくない方法  
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

2. docker network create rosnet
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
3. docker with tmux

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

4. rviz

    ```
    sudo docker network create rosnet
    sudo docker run -it --rm --net rosnet --name master --env ROS_HOSTNAME=master osrf/ros:indigo-desktop-full roscore
    xhost +
    # clients can connect from any host
    sudo docker run -it --rm --net rosnet --name rviz --env ROS_HOSTNAME=rviz --env ROS_MASTER_URI=http://master:11311 --env DISPLAY=unix$DISPLAY --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" osrf/ros:indigo-desktop-full rosrun rviz rviz
    ```


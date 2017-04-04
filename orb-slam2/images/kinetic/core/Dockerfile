# mianki/orb_slam2:core
# 
#
#
FROM minaki/ros-kinetic:base

WORKDIR /
RUN cd /

ENV ROS_PACKAGE_PATH=/root/ORB_SLAM2:/root/ORB_SLAM2/Examples/ROS:/opt/ros/kinetic/share
# add path
RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc && \
      echo "export ROS_PACKAGE_PATH=/root/ORB_SLAM2:/root/ORB_SLAM2/Examples/ROS:/opt/ros/kinetic/share" >> ~/.bashrc && \
      /bin/bash -c "source ~/.bashrc" 


# set bash completion
RUN cd && sed -i '97,99d' ~/.bashrc && \
      echo "# enable bash completion" && \
      echo "if [ -f /etc/bash_completion ] && ! shopt -oq posix; then" >> ~/.bashrc && \
      echo "   . /etc/bash_completion" >> ~/.bashrc && \
      echo "fi" >> ~/.bashrc

# install packages for orb-slam
RUN apt-get update && apt-get install -y\
      libeigen2-dev \
      libx264-dev \
      sphinx-common \
      libsuitesparse-dev \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

# clone orb-slam code
RUN cd && git clone https://github.com/raulmur/ORB_SLAM2.git ORB_SLAM2


RUN cd ~/ORB_SLAM2/ && \
      chmod +x build.sh && \
      chmod +x build_ros.sh 

RUN cd ~/ORB_SLAM2/ && sh build.sh
# have to build manualy
# RUN cd ~/ORB_SLAM2/ && sh build_ros.sh

RUN mkdir -p ~/catkin-ws/src && \
      #catkin_init_workspace && \
      cd ~/catkin-ws/src && \
      git clone https://github.com/bosch-ros-pkg/usb_cam.git 
      #cd .. && \
      #catkin_make 

# add path
RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc && \
      echo "export ROS_PACKAGE_PATH=/root/ORB_SLAM2:/root/ORB_SLAM2/Examples/ROS:/opt/ros/kinetic/share" >> ~/.bashrc && \
      /bin/bash -c "source ~/.bashrc" 


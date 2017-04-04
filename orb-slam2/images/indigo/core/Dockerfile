
# mianki/orb-slam2-indigo:core
#
#
#
FROM minaki/ros-indigo:core

WORKDIR /
RUN cd /

RUN apt-get update && apt-get install -y wget vim tmux libglew-dev 
RUN git clone https://github.com/minaminoki/.dotfiles.git ~/.dotfiles && \
       ln -sf ~/.dotfiles/.tmux.conf.docker ~/.tmux.conf
RUN cd opt && wget http://bitbucket.org/eigen/eigen/get/3.2.10.tar.gz -O eigen3.tgz \
       && tar zxvf eigen3.tgz && cd eigen-eigen-b9cd8366d4e8 \
       && mkdir build && cd build \
       && cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=RELEASE .. \
       && make install \
       && cd /opt && git clone https://github.com/stevenlovegrove/Pangolin.git \
       && cd Pangolin && mkdir build && cd build && cmake .. \
       && make && make install


ENV ROS_PACKAGE_PATH=/root/ORB_SLAM2:/root/ORB_SLAM2/Examples/ROS:/opt/ros/indigo/share:/opt/ros/indigo/stacks
# add path
RUN echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc && \
      echo "export ROS_PACKAGE_PATH=/root/ORB_SLAM2:/root/ORB_SLAM2/Examples/ROS:/opt/ros/indigo/share:/opt/ros/indigo/stacks" >> ~/.bashrc && \
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

RUN apt-get update && apt-get install ros-indigo-usb-cam

# add path
RUN echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc && \
      echo "export ROS_PACKAGE_PATH=/root/ORB_SLAM2:/root/ORB_SLAM2/Examples/ROS:/opt/ros/indigo/share:/opt/ros/indigo/stacks" >> ~/.bashrc && \
      /bin/bash -c "source ~/.bashrc" 




# mianki/orb_slam:base
# 
#
#
FROM minaki/ros:core

WORKDIR /
RUN cd /

# install packages for orb-slam
RUN apt-get update && apt-get install -y\
      libboost-all-dev \
      libsuitesparse-dev \
      libblas-dev \
      liblapack-dev \
      libeigen3-dev

# clone orb-slam code
RUN cd && git clone https://github.com/raulmur/ORB_SLAM.git ORB_SLAM

# add path
RUN echo "export ROS_PACKAGE_PATH=~/ORB_SLAM:$ROS_PACKAGE_PATH" >> ~/.bashrc && \
     /bin/bash -c "source ~/.bashrc"

# build
RUN mkdir ~/ORB_SLAM/Thirdparty/g2o/build && \
      cd ~/ORB_SLAM/Thirdparty/g2o/build && \
      cmake .. -DCMAKE_BUILD_TYPE=Release && \
      make

RUN mkdir ~/ORB_SLAM/Thirdparty/DBoW2/build && \
      cd ~/ORB_SLAM/Thirdparty/DBoW2/build && \
      cmake .. -DCMAKE_BUILD_TYPE=Release && \
      make

# edit manifest.xml
RUN cd ~/ORB_SLAM && \
      sed -i -r "12i\<\!--" manifest.xml && \
      sed -i -r "14i\-->" manifest.xml 

# extract data file
RUN cd ~/ORB_SLAM/Data && tar xvzf ORBvoc.txt.tar.gz


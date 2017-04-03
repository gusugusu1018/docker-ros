# mianki/lsd_slam:core
# 
#
#
FROM minaki/ros:core

WORKDIR /
RUN cd /

# install packages for lsd-slam
RUN apt-get update && apt-get install -y\
      ros-indigo-libg2o \
      ros-indigo-cv-bridge \
      liblapack-dev \
      libblas-dev \
      freeglut3-dev \
      libqglviewer-dev \
      libsuitesparse-dev \
      libx11-dev \
      ros-indigo-usb-cam

# clone lsd-slam
RUN mkdir -p /root/rosbuild_ws/package_dir && \
      cd /root/rosbuild_ws/package_dir && \
      git clone https://github.com/tum-vision/lsd_slam.git lsd_slam

# set enviroment
RUN cd /root/rosbuild_ws && \
      rosws init . /opt/ros/indigo && \
      rosws set -y ~/rosbuild_ws/package_dir -t . && \
      echo 'source ~/rosbuild_ws/setup.bash' >> ~/.bashrc

RUN cd ~/rosbuild_ws/package_dir && \
      sed -i "/^#.*openFabMap/s/^#//" ./lsd_slam/lsd_slam_core/CMakeLists.txt && \
      sed -i "/^#.*FABMAP/s/^#//" ./lsd_slam/lsd_slam_core/CMakeLists.txt

# build
RUN /bin/bash -c " \
      rm /etc/ros/rosdep/sources.list.d/20-default.list && \
      sudo rosdep init && rosdep update && \
      source ~/rosbuild_ws/setup.bash && \
      cd ~/rosbuild_ws && \
      rosmake lsd_slam"

# erase unnecessary things
RUN rm -rf /var/lib/apt/lists/*


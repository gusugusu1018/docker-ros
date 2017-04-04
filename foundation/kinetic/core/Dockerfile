# mianki/ros-kinetic:core
# 
#
#
FROM osrf/ros:kinetic-desktop-full

WORKDIR /
RUN cd /

# install opencv2.4.11
RUN apt-get update && apt-get install -y \
      libopencv-dev build-essential checkinstall \
      cmake pkg-config yasm libtiff5-dev libjpeg-dev \
      libjasper-dev libavcodec-dev libavformat-dev \
      libswscale-dev libdc1394-22-dev libxine2-dev \
      libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev \
      libv4l-dev python-dev python-numpy \
      libtbb-dev libqt4-dev \
      libgtk2.0-dev libmp3lame-dev \
      libopencore-amrnb-dev \
      libopencore-amrwb-dev libtheora-dev \
      libvorbis-dev libxvidcore-dev \
      x264 v4l-utils unzip
      # unable to locate package libfaac-dev

RUN cd && mkdir opencv && cd opencv && \
      git clone https://github.com/Itseez/opencv.git && \
      cd opencv && git checkout tags/2.4.11 && \
      mkdir build && cd build && \
      cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON \
        -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON \
        -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON .. && \
      make -j 4 && \
      make install && \
      sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf' && \
      ldconfig


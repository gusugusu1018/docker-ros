# mianki/ros-kinetic:base
# 
#
#
FROM minaki/ros-kinetic:core

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


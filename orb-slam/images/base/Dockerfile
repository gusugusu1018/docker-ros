# mianki/orb_slam:base
# 
#
#
FROM minaki/orb-slam:core

WORKDIR /

# install packages for my env
RUN apt-get update && apt-get install -y\
     tmux

# clone my env
RUN git clone https://github.com/minaminoki/.dotfiles.git ~/.dotfiles
RUN ln -sf ~/.dotfiles/.tmux.conf.docker ~/.tmux.conf

# set bash completion
RUN cd && sed -i '97,99d' ~/.bashrc && \
      echo "# enable bash completion" && \
      echo "if [ -f /etc/bash_completion ] && ! shopt -oq posix; then" >> ~/.bashrc && \
      echo "   . /etc/bash_completion" >> ~/.bashrc && \
      echo "fi" >> ~/.bashrc


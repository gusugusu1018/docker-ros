# mianki/orb_slam:base
# 
#
#
FROM minaki/orb-slam:base

WORKDIR /
RUN cd /

# install packages for my env
RUN apt-get update && apt-get install -y\
      zsh vim tmux tree figlet
# clone my env
RUN git clone https://github.com/minaminoki/.dotfiles.git ~/.dotfiles
RUN curl -sL zplug.sh/installer | zsh
RUN cd && curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh && \
      sh ./install.sh
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
     ~/.fzf/install
RUN chmod +x ~/.dotfiles/ln.sh && sh ~/.dotfiles/ln.sh


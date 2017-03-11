# dockerでlsd-slamしたい
[CHItAさんのgithub repository](https://github.com/CHItA/ros-docker)を使ってやってみる。

```
git clone https://github.com/CHItA/ros-docker.git
cd ros-docker/images/ros-indigo
sudo docker pull ubuntu:trusty
sudo docker build --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) --build-arg USERNAME=${USER} -t ros-indigo:latest .
```

しかし、エラー
```
gpg: requesting key B01FA116 from hkp server ha.pool.sks-keyservers.net
gpg: keyserver timed out
gpg: keyserver receive failed: keyserver error
```
セキュリティーの関係か、違うネットワークに属す、違うPCでは実行できた。  
このbuildではpureなubuntu:trustyからすべて環境構築をしているので、とても長い。  
みると、openCVをbuildしているから長いよう。  

Dockerfileの書き方がとても参考になる。  

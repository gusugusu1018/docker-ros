# docker ros
I'm beginner of ros and docker.  
This is just memo for these.  

## docker install
```
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt-get install docker-ce
apt-cache madison docker-ce
```
## docker test
```
sudo docker run hello-world
```

## docker pull ros
```
sudo docker pull osrf/ros:indigo-desktop-full
```


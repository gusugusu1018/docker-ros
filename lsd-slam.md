# lsd-slam on docker

## build
```
cd lsd-slam/images
make build
```
## camera calibration
read camera-calibration.md

## sample data
```
cd lsd-slam/
sh run.sh
```
```
tmux
sudo apt update
sudo apt install wget
cd
wget http://vmcremers8.informatik.tu-muenchen.de/lsd/LSD_room.bag.zip
roscore > /dev/null &
rosrun lsd_slam_viewer viewer &
rosrun lsd_slam_core live_slam image:=/image_raw camera_info:=/camera_info &
rosbag play ~/LSD_room.bag
```

## using_camera
```
roscore
rosrun lsd_slam_viewer viewer
rosrun usb_cam usb_cam_node
rosrun lsd_slam_core live_slam /image:=/usb_cam/image_raw /camera_info:=/usb_cam/camera_info
```

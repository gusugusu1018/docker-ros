# camera calibration
## set camera aveailale
```
cd docker-run
chmod +x enable_camera.sh
ls -l /dev/video*
# if you want to use /dev/video0
# if you want to use /dev/video1
# you have to fix enable_camera.sh /dev/video0 -> /dev/video1
sh enable_camera.sh
```
## docker run
```
cd ../orb-slam/
chmod +x dev-run.sh
sh ./dev-run.sh
```
## calibration 
```
tmux
roscore
rosrun usb_cam usb_cam_node
# if you use ptam calib board
rosrun camera_caribrarion cameracalibrator.pt --size 11x7 --square 0.02 image:=/usb_cam/image_raw
# hold the board over the camera many times
# click CALIBRATE
# wait a minute
# if the buttons appears, hold the boad over the camera and click SAVE
# repeat several times
# click COMMIT
ls /tmp
# if calibration.tar.gz exists, calibration succeeded
cd
mkdir /root/calib/
mv /tmp/calibration.tar.gz /root/calib
cd /root/calib
tar xvzf calibration.tar.gz
sed -i '3d' ost.yaml
sed -i -e "3i camera_name: head_camera" ost.yaml
cp /root/calib/ost.yaml /root/.ros/camera_info/head_camera.yaml
```


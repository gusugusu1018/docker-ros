#!/bin/sh
mkdir /root/calib/
mv /tmp/calibrationdata.tar.gz /root/calib/
cd /root/calib/
tar xvzf calibration.tar.gz
mkdir /root/.ros/camera_info/
sed -i '3d' ost.yaml
sed -i -e "3i camera_name: head_camera" ost.yaml
cp ost.yaml /root/.ros/camera_info/head_camera.yaml


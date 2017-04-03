#!/bin/bash
echo "Building ROS nodes"

mkdir /root/ORB_SLAM/build
cd /root/ORB_SLAM/build
cmake .. -DROS_BUILD_TYPE=Release
make


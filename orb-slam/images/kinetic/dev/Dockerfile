# mianki/orb_slam:dev
# 
#
#
FROM minaki/kinetic/orb-slam:base

WORKDIR /root/


RUN mkdir ~/ORB_SLAM/build
RUN cd ~/ORB_SLAM/build && \
      /bin/bash -c "cmake .. -DROS_BUILD_TYPE=Release " && \
      make

# calibration
RUN rosdep install camera_calibration && rosmake camera_calibration
# manualy
# rosrun usb_cam usb_cam_node
## ptam calib board
# rosrun camera_calibration cameracalibrator.py --size 11x7 --square 0.02 image:=/usb_cam/image_raw

COPY ./calib-param-set.sh /root/


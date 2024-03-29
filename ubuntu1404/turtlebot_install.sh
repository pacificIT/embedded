#!/bin/bash
set -x
set -e
source ~/.bashrc
#Install turtlebot navigation and other ROS software
sudo apt-get -y install ros-indigo-navigation ros-indigo-amcl ros-indigo-camera-calibration ros-indigo-calibration ros-indigo-clear-costmap-recovery ros-indigo-cv-bridge ros-indigo-dynamic-reconfigure ros-indigo-hokuyo-node ros-indigo-image-geometry ros-indigo-image-proc ros-indigo-image-view ros-indigo-joy ros-indigo-kobuki ros-indigo-kobuki-description ros-indigo-kobuki-auto-docking ros-indigo-kobuki-bumper2pc ros-indigo-kobuki-node ros-indigo-kobuki-rapps ros-indigo-laser-filters ros-indigo-libg2o ros-indigo-pcl-ros ros-indigo-rocon ros-indigo-rosbridge-server ros-indigo-sensor-msgs ros-indigo-turtlebot ros-indigo-usb-cam sudo ros-indigo-turtlebot-msgs ros-indigo-kobuki-dashboard ros-indigo-urg-c chrony

#sync time to ubuntu.com
sudo ntpdate ntp.ubuntu.com

#download and install our code and source dependencies
mkdir ~/robot2020
cd ~/robot2020
mkdir ~/robot2020/src
cd ~/robot2020/src
git clone -b hydro-devel https://github.com/ixirobot/robot2020.git
git clone -b bosch_robot_devel https://github.com/bosch-ros-pkg/navigation.git
git clone -b indigo-devel https://github.com/bosch-ros-pkg/urg_node.git
git clone -b master https://github.com/RobotWebTools/mjpeg_server.git
git clone https://github.com/turtlebot/turtlebot.git
git clone https://github.com/WPI-RAIL/robot_pose_publisher.git
cd ~/robot2020
set +e
rosdep install --from-paths src --ignore-src --rosdistro indigo -y
set -e
catkin_make
#install the udev rules
source ~/robot2020/devel/setup.bash
sudo cp ~/robot2020/src/robot2020/config/udev_rules/97-iximove-inforce.rules /etc/udev/rules.d/
rosrun kobuki_ftdi create_udev_rules



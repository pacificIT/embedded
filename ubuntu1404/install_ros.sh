#!/bin/bash
set -x
set -e

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'
wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -

#Install ROS bare-bones
sudo apt-get update
sudo apt-get -y install ros-indigo-desktop-full

echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
source ~/.bashrc

#Install rosdep for compiled sources
sudo apt-get -y install python-rosdep
sudo rosdep init
rosdep update

#Install rosinstall
sudo apt-get -y install python-rosinstall

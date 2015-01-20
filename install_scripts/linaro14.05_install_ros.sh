#!/bin/bash
set -x
sudo apt-get install git emacs
sudo apt-get install wget 

#Setup sources.list
sudo sh -c 'echo "\ndeb http://ports.ubuntu.com/ubuntu-ports/ trusty restricted" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb-src http://ports.ubuntu.com/ubuntu-ports/ trusty restricted\n" >> /etc/apt/sources.list'

sudo sh -c 'echo "deb http://ports.ubuntu.com/ubuntu-ports/ trusty multiverse" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb-src http://ports.ubuntu.com/ubuntu-ports/ trusty multiverse" >> /etc/apt/sources.list'

sudo sh -c 'echo "deb http://packages.namniart.com/repos/ros trusty main" > /etc/apt/sources.list.d/ros-latest.list'

#Set locale for Boost and others.
sudo update-locale LANG=C LANGUAGE=C LC_ALL=C LC_MESSAGES=POSIX
wget http://packages.namniart.com/repos/namniart.key -O - | sudo apt-key add -

#Install ROS bare-bones
sudo apt-get update
sudo apt-get install ros-indigo-ros-base

#Setup bashrc
echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
source ~/.bashrc

#Install rosdep for compiled sources
sudo apt-get install python-rosdep
sudo rosdep init
rosdep update

#Install rosinstall
sudo apt-get install python-rosinstall
cp /etc/lsb-release linaro_lsb-release

#Update OS name
sudo sh -c 'echo "DISTRIB_ID=Ubuntu" > /etc/lsb-release'
sudo sh -c 'echo "DISTRIB_RELEASE=14.04" >> /etc/lsb-release'
sudo sh -c 'echo "DISTRIB_CODENAME=trusty" >> /etc/lsb-release'
sudo sh -c 'echo "DISTRIB_DESCRIPTION=\"Ubuntu 14.04\"" >> /etc/lsb-release'


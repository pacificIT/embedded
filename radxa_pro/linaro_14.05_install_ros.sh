#!/bin/bash
set -x
sudo apt-get -y install git emacs vim wget gparted
#http://serverfault.com/questions/545622/no-more-logging-after-upgrade-to-debian-wheezy
sudo apt-get -y install inetutils-syslogd

#Enable CDC ACM for Hokuyo, Arduino, etc...
sudo cp cdc-acm.ko /lib/modules/3.0.36+/kernel/drivers/usb/serial/
sudo sh -c 'echo "cdc_acm" > /etc/modules-load.d/cdc_acm.conf'
sudo depmod -a
sudo modprobe cdc_acm

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
sudo apt-get -y install ros-indigo-ros-base

#Setup bashrc
echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
source ~/.bashrc

#Install rosdep for compiled sources
sudo apt-get -y install python-rosdep
sudo rosdep init
rosdep update

#Install rosinstall
sudo apt-get -y install python-rosinstall
cp /etc/lsb-release linaro_lsb-release

#Update OS name
sudo sh -c 'echo "DISTRIB_ID=Ubuntu" > /etc/lsb-release'
sudo sh -c 'echo "DISTRIB_RELEASE=14.04" >> /etc/lsb-release'
sudo sh -c 'echo "DISTRIB_CODENAME=trusty" >> /etc/lsb-release'
sudo sh -c 'echo "DISTRIB_DESCRIPTION=\"Ubuntu 14.04\"" >> /etc/lsb-release'


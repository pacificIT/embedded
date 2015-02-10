#!/bin/bash
set -x
set -e

sudo apt-get -y install pyqt4-dev-tools libjack-dev libbluetooth-dev
tar xzf QtSixA-1.5.1-src.tar.gz
cd QtSixA-1.5.1/
patch -p1 < ../qtsixa_ubuntu.patch
make
sudo make install


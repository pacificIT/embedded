#! /bin/bash
set -x
brew update
brew install cmake

#### Added by Hai ####
sudo pip install -U numpy
brew install console_bridge poco eigen sip tinyxml qt pyqt curl gtest lz4 jpeg libpng fltk libtool yaml-cpp boost-python 
# https://github.com/Homebrew/homebrew-science/issues/1624
brew install https://github.com/fran6co/homebrew-science/raw/pcl-boost/pcl.rb
brew install opencv urdfdom urdfdom_headers qhull assimp collada-dom 
brew install Caskroom/cask/xquartz
brew install gtk+ gtk+3 openni2 gazebo4 libogg theora shiboken pyside 
#### Added by Hai ####


brew tap ros/deps
brew tap osrf/simulation
brew tap homebrew/versions 
brew tap homebrew/science
mkdir -p ~/Library/Python/2.7/lib/python/site-packages
echo "$(brew --prefix)/lib/python2.7/site-packages" >> ~/Library/Python/2.7/lib/python/site-packages/homebrew.pth
sudo easy_install pip
sudo pip install -U setuptools
sudo pip install -U wstool rosdep rosinstall rosinstall_generator
rospkg catkin-pkg Distribute sphinx

#### Added by Hai ####
sudo pip install empy
#### Added by Hai ####

sudo rosdep init
rosdep update

mkdir ~/ros_catkin_ws
cd ~/ros_catkin_ws
rosinstall_generator desktop_full --rosdistro indigo --deps --wet-only --tar > indigo-desktop-full-wet.rosinstall
wstool init -j8 src indigo-desktop-full-wet.rosinstall
rosdep install --from-paths src --ignore-src --rosdistro indigo -y

#### Added by Hai ####
#Fix for bug https://github.com/ros-perception/image_common/issues/28
wget https://raw.githubusercontent.com/ros-perception/image_common/b756d8187ed71a2dde9e14f78898ec448dcd47c0/image_transport/CMakeLists.txt
mv -f CMakeLists.txt src/image_common/image_transport/

#Fix for new version of openni2_camera CMake breaking OS X support
wget https://raw.githubusercontent.com/ros-drivers/openni2_camera/5488b52720174cdd27c19c0481d71597b70d2a34/CMakeLists.txt
mv -f CMakeLists.txt src/openni2_camera/

#Fix for rviz: interactions between qt and boost.
content=$(cat /usr/local/Cellar/boost/1.57.0/include/boost/type_traits/detail/has_binary_operator.hpp)
echo -en "#ifndef Q_MOC_RUN\n$content" > /usr/local/Cellar/boost/1.57.0/include/boost/type_traits/detail/has_binary_operator.hpp
echo "#endif" >> /usr/local/Cellar/boost/1.57.0/include/boost/type_traits/detail/has_binary_operator.hpp

#Fix for rviz: assimp detection.
wget https://raw.githubusercontent.com/ros-visualization/rviz/18b224543e6426f851667b828f62c864fa29816f/CMakeLists.txt
mv -f CMakeLists.txt src/rviz/
wget https://raw.githubusercontent.com/ros-visualization/rviz/18b224543e6426f851667b828f62c864fa29816f/src/rviz/CMakeLists.txt
mv -f CMakeLists.txt src/rviz/src/rviz/

#Fix for rviz and old ogre 1.7
# http://answers.ros.org/question/186635/rviz-crashes-on-indigo-osx-due-to-serializer-implementation/
wget https://github.com/ros-visualization/rviz/raw/99128d434adfd1bb72f1be8db00ded0364bbb7b2/ogre_media/models/rviz_cone.mesh
mv -f rviz_cone.mesh src/rviz/ogre_media/models/

wget https://github.com/ros-visualization/rviz/raw/99128d434adfd1bb72f1be8db00ded0364bbb7b2/ogre_media/models/rviz_cube.mesh
mv -f rviz_cube.mesh src/rviz/ogre_media/models/

wget https://github.com/ros-visualization/rviz/raw/99128d434adfd1bb72f1be8db00ded0364bbb7b2/ogre_media/models/rviz_cylinder.mesh
mv -f rviz_cylinder.mesh src/rviz/ogre_media/models/

wget https://github.com/ros-visualization/rviz/raw/99128d434adfd1bb72f1be8db00ded0364bbb7b2/ogre_media/models/rviz_sphere.mesh
mv -f rviz_sphere.mesh src/rviz/ogre_media/models/
#### Added by Hai ####
./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release
source ~/ros_catkin_ws/install_isolated/setup.bash
echo "source ~/ros_catkin_ws/install_isolated/setup.bash" >> ~/.bashrc

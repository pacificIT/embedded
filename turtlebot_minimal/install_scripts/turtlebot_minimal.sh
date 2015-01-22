mkdir turtlebot_minimal
mkdir turtlebot_minimal/src
cd turtlebot_minimal/src

wstool init src -j5 turtlebot_minimal.rosinstall
source /opt/ros/indigo/setup.bash
#rosdep install --from-paths src -i -y
catkin_make

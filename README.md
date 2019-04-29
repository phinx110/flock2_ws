# REQUIREMENTS 

see submodule flock2 for the list of requirements

# COMPILING

```
source /opt/ros/crystal/setup.bash
cd flock2_ws
colcon build --event-handlers console_direct+ --packages-skip tello_gazebo --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo
source ~/flock2_new_ws/install/setup.bash
```

# SETTING UP THE NETWORK


```
sudo iw dev wlp59s0 interface add wlp59s1 type station addr 9c:b6:d0:c0:f1:50
```

now you have two virtual wifi adapters. connect each of them to a drone.
after this, we rewrite ip addresses so that they don't conflict anymore:
```
bash setup_multi.sh
```

# RUNNING

source /opt/ros/crystal/setup.bash
source ~/flock2_ws/install/setup.bash
ros2 launch flock2 launch_two.py


# ros1 bridge (for camera calib)

ROS1 bridge opstarten
* een ros1 environment maken : nieuwe terminal opendoen en preppen voor ros1
* . /opt/ros/melodic/local_setup.bash
* start roscore en je krijgt een ROS_MASTER_UI

dan in een andere terminal waar je ros2 hebt geinitialiseerd:
* LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/ros/melodic/lib/ ROS_MASTER_URI=http://localhost:11311 ros2 run ros1_bridge dynamic_bridge --bridge-all-topics

dan kan je normaalgezien in uw ros1 environment dingen lanceren:
* rosrun camera_calibration cameracalibrator.py --size 8x6 --square 0.108 image:=/solo/image_raw camera:=/solo
* rosrun image_view image_view image:=/solo/image_raw


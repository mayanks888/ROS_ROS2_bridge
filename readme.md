#### Creating Ros and Ros2 bridge
In this example we will read the msg from rosbag based on ROS (Melodic) in  ROS2 - Dashing)

1) Build docker image with ros  melodic and ros dashing.

    ```
    refer to attached dockerfile and build docker image
    eg : docker build . -t ros1ros2bridge
    ```
2) Load docker image

    ```
    docker run -it --rm -v <source_path>:/<destination_path> <image_name> bash
    docker run -it --rm -v /home/mayank_s/codebase/AI/ROS_ROS2_bridge:/myspace 26a bash
    ```

3) Open `first terminal : terminal 1` and source ROS melodic setup files

   ```
   source /opt/ros/melodic/setup.bash
   ```
4) Enter  `roscore` in same terminal `terminal 1`

   ```
   roscore
   ```
5) Open `second terminal : terminal 2` and source ros melodic followed by ros dashing `same terminal : terminal 2`

   ```
   source /opt/ros/melodic/setup.bash
   source /opt/ros/dashing/setup.bash
   ```

6) Enter command for dynamic birdge in the `same terminal i.e terminal 2`

   ```
   ros2 run ros1_bridge dynamic_bridge --bridge-all-topics
   		or 
   ros2 run ros1_bridge dynamic_bridge		
   ```

7) Create `third terminal : terminal 3` and run rosbag file based on ros

   ```
   source /opt/ros/melodic/setup.bash
   rosbag play  2019-09-27-14-39-43.bag
   ```

8) Open `forth terminal terminal 4` and check rostopic list in ros2 node
    ```
    source /opt/ros/dashing/setup.bash
    ros2 topic list
    ```

10) To check any msg

    ```
    ros2 topic echo /<topic>
    ros2 topic echo /tf_static
    ```
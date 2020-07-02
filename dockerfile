FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

# RUN sed -i -e 's/http:\/\/archive/mirror:\/\/mirrors/' -e 's/\/ubuntu\//\/mirrors.txt/' /etc/apt/sources.list

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install apt-utils locales && \
    rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8


RUN apt-get update && \
    apt-get -y upgrade  && \
    apt-get -y install sudo vim nano net-tools curl gdb gdbserver gnupg2 \
    lsb-release bash-completion git cron && \
    rm -rf /var/lib/apt/lists/*

ENV ROS_DISTRO=dashing
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'


RUN apt-get update && \
    apt-get -y install python3-colcon-common-extensions python3-argcomplete \
    ros-$ROS_DISTRO-ros-base ros-$ROS_DISTRO-rclcpp-components ros-$ROS_DISTRO-ros2component \
    ros-$ROS_DISTRO-rosbag2 ros-$ROS_DISTRO-rosbag2-storage-default-plugins ros-$ROS_DISTRO-ros2bag ros-$ROS_DISTRO-launch*  \
    ros-$ROS_DISTRO-cv-bridge ros-$ROS_DISTRO-librealsense2 ros-$ROS_DISTRO-message-filters ros-$ROS_DISTRO-image-transport && \
    rm -rf /var/lib/apt/lists/*

# Installing Boost library 
RUN apt-get install -y libboost-all-dev \
        libeigen3-dev -y && \
        sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
        apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

#install ros1-ros2 bridge
RUN apt-get update && \
        apt-get -y install ros-dashing-ros1-bridge

ENV ROS_DOMAIN_ID=0

CMD ["/bin/bash"]

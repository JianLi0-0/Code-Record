# 使用官方Ubuntu基础镜像
FROM ros:noetic
# FROM arm64v8/ros:noetic

# # 安装SSH服务
# RUN apt-get update && apt-get install -y openssh-server

# RUN apt-get install -y \
#     build-essential \
#     gedit

# 设置SSH无密码登录（非生产建议）
RUN mkdir /var/run/sshd
# RUN echo 'root:root' | chpasswd
# RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN useradd -m honymow
RUN echo 'honymow:honymow' | chpasswd
RUN apt-get update && \
    apt-get install -y sudo && \
    usermod -aG sudo honymow && \
    echo 'honymow ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN apt-get install -y ros-noetic-rviz ros-noetic-global-planner \
    ros-noetic-xacro ros-noetic-mobile-robot-simulator prtobuf-compiler \
    python3 python3-pip python3-matplotlib openssh-server nano 

# 确保SSH服务在容器启动时自动运行
CMD ["/usr/sbin/sshd", "-D"]

RUN /bin/bash -c "source /opt/ros/noetic/setup.bash"

# 暴露22端口
EXPOSE 22

# docker build -t arm-ros .
# docker run -d -p 2222:22 --name arm_ros_container arm-ros
# docker inspect bridge
# docker run -it --rm --name arm-container --platform linux/arm/v7 arm32v7/ubuntu /bin/bash
# docker exec -it arm_ros bash
# 在创建容器之前，一定要先在terminal内输入xhost +命令，以解除Xserver服务器的限制，成功后会打印
# access control disabled, clients can connect from any host
# docker run -it --device=/dev/dri --group-add video --volume=/tmp/.X11-unix:/tmp/.X11-unix  --env="DISPLAY=$DISPLAY"  --name=[ros-display] [IMAGE_ID]  /bin/bash


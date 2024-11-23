FROM arm64v8/ros:noetic

# Add ubuntu user with same UID and GID as your host system, if it doesn't already exist
# Since Ubuntu 24.04, a non-root user is created by default with the name vscode and UID=1000
#ARG USERNAME=ubuntu
#ARG USER_UID=1000
#ARG USER_GID=$USER_UID
#RUN if ! id -u $USER_UID >/dev/null 2>&1; then \
#        groupadd --gid $USER_GID $USERNAME && \
#        useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME; \
#    fi
## Add sudo support for the non-root user
#RUN apt-get update && \
#    apt-get install -y sudo && \
#    echo "$USERNAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME && \
#    chmod 0440 /etc/sudoers.d/$USERNAME
#
## Switch from root to user
#USER $USERNAME
#
## Add user to video group to allow access to webcam
#RUN sudo usermod --append --groups video $USERNAME

# Update all packages
#RUN sudo apt update && sudo apt upgrade -y

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y openssh-server && \
    mkdir /var/run/sshd && \
    echo 'root:root' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22

# Install Git
RUN sudo apt install -y git net-tools clang ninja-build gdb nano rsync
RUN sudo apt install -y protobuf-compiler libgoogle-glog-dev libompl-dev ros-noetic-xacro ros-noetic-mobile-robot-simulator ros-noetic-map-server
RUN sudo apt install -y ros-noetic-grid-map-rviz-plugin ros-noetic-cv-bridge ros-noetic-octomap-msgs ros-noetic-image-transport ros-noetic-image-geometry
RUN sudo apt install -y ros-noetic-tf ros-noetic-ruckig ros-noetic-angles ros-noetic-filters libtbb-dev libopencv-dev libpcl-dev ros-noetic-pcl-ros
RUN sudo apt install -y libyaml-cpp-dev ros-noetic-rviz ros-noetic-mbf-msgs ros-noetic-move-base-msgs ros-noetic-costmap-2d ros-noetic-nav-core
RUN sudo apt install -y ros-noetic-tf2-ros ros-noetic-base-local-planner ros-noetic-clear-costmap-recovery ros-noetic-navfn ros-noetic-rotate-recovery
RUN sudo apt install -y ros-noetic-tf2-geometry-msgs ros-noetic-global-planner ros-noetic-ompl ros-noetic-tf2-sensor-msgs ros-noetic-robot-state-publisher
RUN sudo apt install -y ros-noetic-joint-state-publisher gazebo11 ros-noetic-octomap ros-noetic-gazebo-ros ros-noetic-amcl
RUN sudo apt install -y libxxhash-dev libxdamage-dev libxfixes-dev libxkbfile-dev libxrandr-dev libxtst-dev libxcomposite-dev libxres-dev libgtk-3-dev python3-gi-cairo python-gi-dev python3-cairo-dev gobject-introspection libgirepository1.0-dev libx264-dev libvpx-dev xvfb

# 下载并安装 Miniconda for ARM64
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh -O /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -b -p /opt/conda \
    && rm /tmp/miniconda.sh

# 添加 conda 到 PATH
ENV PATH="/opt/conda/bin:$PATH"

RUN conda create -n xpra_env python=3.10 -y
RUN conda init
RUN /opt/conda/envs/xpra_env/bin/python -m pip install xpra
RUN conda init --reverse

RUN ln -s /opt/conda/envs/xpra_env/bin/xpra /usr/local/bin/xpra
RUN echo '/usr/lib/aarch64-linux-gnu/libffi.so.7' | sudo tee -a /etc/ld.so.preload
RUN echo "export DISPLAY=:666" >> ~/.bashrc

# Source the ROS setup file
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc

CMD ["/usr/sbin/sshd", "-D"]
#CMD ["sh", "-c", "/usr/sbin/sshd && xpra start --no-daemon :666 --bind-tcp=0.0.0.0:14500"]

################################
## ADD ANY CUSTOM SETUP BELOW ##
################################

# docker build -t noetic-ssh-xpra .
# docker run -p 192.168.1.86:2022:22 -p 5900:5900 -p 192.168.1.86:14500:14500 -v /Users/lijian/Downloads/shared_folders:/home/shared_folders --name company-noetic-container -d noetic-ssh-xpra:latest

# xpra start ssh://root@192.168.1.86:2022 --start-child=xterm
# xpra attach tcp://root@192.168.1.86:14500/666

# alias attach_xpra='nohup xpra attach tcp://root@192.168.1.86:14500/666 > output.log 2>&1 &'
# alias start_xpra='docker exec -d company-noetic-container xpra start --no-daemon :666 --bind-tcp=0.0.0.0:14500'

# mamba create -n noetic2 python=3.9 abseil-cpp
# mamba install ros-noetic-desktop-full ompl rsync ros-noetic-tf2-ros ros-noetic-base-local-planner ros-noetic-clear-costmap-recovery ros-noetic-navfn
#ros-noetic-rotate-recovery ros-noetic-mbf-msgs ros-noetic-move-base-msgs ros-noetic-map-server ros-noetic-cv-bridge ros-noetic-octomap-msgs ros-noetic-image-transport
#ros-noetic-image-geometry ros-noetic-tf ros-noetic-ruckig ros-noetic-angles ros-noetic-filters ros-noetic-pcl-ros ros-noetic-tf2-geometry-msgs ros-noetic-global-planner
#ros-noetic-ompl ros-noetic-tf2-sensor-msgs ros-noetic-robot-state-publisher
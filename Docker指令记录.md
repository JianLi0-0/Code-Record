### 
# 创建一个新的 Docker 网络
docker network create --driver=bridge --subnet=192.168.1.0/24 --gateway=192.168.1.1 my_wifi_network
 
# 启动一个容器，并将其连接到你的 WiFi 网络
docker run --network=my_wifi_network -d my_docker_image

# 
docker run -it -d --privileged --name test-noetic --network=docker-bride -u root --userns=host -v /Users/lijian/Downloads/shared_folders:/home/shared_folders arm64v8/ros:noetic /bin/bash

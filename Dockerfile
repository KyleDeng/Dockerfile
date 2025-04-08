# 使用官方提供的镜像作为基础镜像
FROM ubuntu:24.04

# 添加一些属性
LABEL maintainer="Huatuo"
LABEL build_cmd="docker build -f ./Dockerfile -t u24-github-runner:1.0.0 ."

# 设置环境变量
ENV TZ Asia/Shanghai

# 镜像创建过程中执行的命令 可以多条
RUN buildDeps='gcc libc6 libusb-1.0-0-dev bzip2 make cmake ninja-build python3 python3-pip python3-venv curl vim tmux ssh net-tools iputils-ping git sudo' \
        && apt-get update \
        && apt-get install -y $buildDeps \
        && mv /usr/lib/python3.12/EXTERNALLY-MANAGED /usr/lib/python3.12/EXTERNALLY-MANAGED.bak \
        && pip3 install requests

# 创建新用户
RUN useradd -ms /bin/bash runner

# 工作目录设置
WORKDIR /actions-runner


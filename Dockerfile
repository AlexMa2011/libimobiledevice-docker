FROM ubuntu:latest

# 安装运行时依赖
RUN apt-get update && apt-get install -y \
    libusb-1.0-0 \
    usbmuxd \
    && rm -rf /var/lib/apt/lists/*

# 复制构建好的文件
COPY libimobiledevice.tar /
RUN tar -xvf /libimobiledevice.tar -C / && rm /libimobiledevice.tar

# 更新库缓存
RUN ldconfig

# 设置工作目录
WORKDIR /app

# 设置默认命令
CMD ["bash"]

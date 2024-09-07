FROM ubuntu:latest

ARG CUSTOM_VERSION

# 安装必要的运行时依赖
RUN apt-get update && apt-get install -y \
    libssl3 \
    libusb-1.0-0 \
    && rm -rf /var/lib/apt/lists/*

# 复制编译好的 libimobiledevice
COPY dest/usr/local /usr/local

# 更新动态链接器缓存
RUN ldconfig

# 设置工作目录
WORKDIR /app

# 如果提供了自定义版本，则创建一个版本文件
RUN if [ -n "$CUSTOM_VERSION" ]; then echo $CUSTOM_VERSION > /app/version.txt; fi

# 设置默认命令
CMD ["bash"]

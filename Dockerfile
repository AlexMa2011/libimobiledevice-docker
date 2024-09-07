FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    autoconf \
    automake \
    libtool \
    pkg-config \
    libssl-dev \
    libusb-1.0-0-dev \
    libplist-dev \
    python3-dev \
    python3-pip \
    python3-venv \
    usbmuxd

# 创建并激活虚拟环境，然后安装 Cython
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip3 install --no-cache-dir cython

# 克隆并编译 libplist
RUN git clone https://github.com/libimobiledevice/libplist.git && \
    cd libplist && \
    ./autogen.sh && \
    make && \
    make install

# 克隆并编译 libusbmuxd
RUN git clone https://github.com/libimobiledevice/libusbmuxd.git && \
    cd libusbmuxd && \
    ./autogen.sh && \
    make && \
    make install

# 克隆并编译 libimobiledevice-glue
RUN git clone https://github.com/libimobiledevice/libimobiledevice-glue.git && \
    cd libimobiledevice-glue && \
    ./autogen.sh && \
    make && \
    make install

# 克隆并编译 libimobiledevice
RUN git clone https://github.com/libimobiledevice/libimobiledevice.git && \
    cd libimobiledevice && \
    ./autogen.sh && \
    make && \
    make install

# 更新库缓存
RUN ldconfig

# 设置工作目录
WORKDIR /app

# 复制您的应用程序代码（如果有的话）
# COPY . .

# 设置默认命令
CMD ["bash"]

# Use runtime as the base image
FROM ubuntu

# Install FFmpeg and Chinese fonts
RUN apt-get update && \
    apt-get install -y \
    wget \
    gnupg \
    ca-certificates \
    curl \
    unzip \
    fontconfig \
    fonts-noto-cjk-extra \
    ttf-wqy-microhei \
    locales \
    jq \
    openjdk-17-jdk \
    && apt-get update \
    && apt-get install -y ffmpeg \
    && apt-get install -y libasound2t64 \
    xvfb \
    # install adspower
    && wget https://version.adspower.net/software/linux-x64-global/AdsPower-Global-7.3.26-x64.deb \
    && apt install -y ./AdsPower-Global-7.3.26-x64.deb \
    && rm -f ./AdsPower-Global-7.3.26-x64.deb \
    # 中文环境配置
    && sed -i 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen \
    && fc-cache -fv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/*

# 设置中文环境变量
ENV LANG=zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8

# Set the working directory
WORKDIR /app

# Default command
CMD ["bash"]

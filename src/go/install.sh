#!/bin/bash

set -e

# 根据用户选择的镜像源设置 BASE_URL
case "$MIRROR" in
  "ustc")
    BASE_URL="https://mirrors.ustc.edu.cn/golang"
    ;;
  "aliyun")
    BASE_URL="https://mirrors.aliyun.com/golang"
    ;;
  "nju")
    BASE_URL="https://mirror.nju.edu.cn/golang"
    ;;
  *)
    BASE_URL="https://go.dev/dl"
    ;;
esac

# 构建下载链接
DOWNLOAD_URL="$BASE_URL/go${VERSION}.linux-${ARCH}.tar.gz"

# 下载并解压Go
echo "Downloading Go $VERSION..."
curl -fsSL "$DOWNLOAD_URL" | tar -C /usr/local -xz

# 设置Go环境变量
echo "Setting up Go environment variables..."
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.bashrc
source ~/.bashrc

# 验证Go版本
go version
go env -w GOPROXY=https://goproxy.cn,direct
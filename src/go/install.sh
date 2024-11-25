#!/bin/bash

set -e

# 获取最新的Go版本
GO_VERSION=$(curl -s https://go.dev/dl/ | grep -oP 'go\d+\.\d+\.\d+\.linux-amd64\.tar\.gz' | head -n 1 | sed 's/\.tar\.gz//')

# 构建下载链接
DOWNLOAD_URL="https://go.dev/dl/${GO_VERSION}.tar.gz"

# 下载并解压Go
echo "Downloading Go $GO_VERSION..."
curl -fsSL "$DOWNLOAD_URL" | tar -C /usr/local -xz

# 设置Go环境变量
echo "Setting up Go environment variables..."
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.bashrc
source ~/.bashrc

# 验证Go版本
go version

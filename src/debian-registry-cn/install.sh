#!/bin/bash
set -e

echo "Switching Debian APT registry to China mirror..."

# 根据用户选项设置镜像源
case "${MIRROR}" in
  "tsinghua")
    SED_REPLACE="s/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g"
    ;;
  "ustc")
    SED_REPLACE="s/deb.debian.org/mirrors.ustc.edu.cn/g"
    ;;
  "aliyun")
    SED_REPLACE="s/deb.debian.org/mirrors.aliyun.com/g"
    ;;
  *)
    echo "Invalid mirror option: ${MIRROR}"
    exit 1
    ;;
esac

# 写入新的镜像源
sed -i "${SED_REPLACE}" /etc/apt/sources.list.d/debian.sources

echo "APT sources switched to ${MIRROR}"

# 更新 APT 缓存
apt-get update

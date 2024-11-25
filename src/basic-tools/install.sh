#!/bin/bash
set -e

echo "Installing Basic Tools..."

# 根据用户选项安装工具
# if [ "${INSTALLGIT}" = "true" ]; then
#   echo "Installing Git..."
#   apt-get update && apt-get install -y git
# fi

if [ "${INSTALLCURL}" = "true" ]; then
  echo "Installing Curl..."
  apt-get update && apt-get install -y curl
fi

# if [ "${INSTALLVIM}" = "true" ]; then
#   echo "Installing Vim..."
#   apt-get update && apt-get install -y vim
# fi

echo "Basic tools installation completed!"

#!/bin/bash

set -e

NODE_MIRROR=${NODEMIRROR:-"nju"}
NODE_VERSION=${NODEVERSION:-"lts"}
NPM_MIRROR=${NPMMIRROR:-"tencent"}
GH_PROXY=${GHPROXY:-""}

nvm_install_shell_url=https://raw.githubusercontent.com/nvm-sh/nvm/refs/heads/master/install.sh

# 判断 URL 是否以 / 结尾
if [[ "$GH_PROXY" == */ ]]; then
  # 去掉结尾的 /
  GH_PROXY="${GH_PROXY%/}"
fi
if [ "${GH_PROXY}" != "" ]; then
  nvm_install_shell_url=$GH_PROXY/$nvm_install_shell_url
fi

echo "Installing nvm..."

mkdir -p $NVM_DIR

curl -L $nvm_install_shell_url -o /tmp/install.sh

if [ "${GH_PROXY}" != "" ]; then
  sed -i "s#https://raw#${GH_PROXY}/https://raw#g" /tmp/install.sh
  sed -i "s#https://github#${GH_PROXY}/https://github#g" /tmp/install.sh
fi

bash /tmp/install.sh

[ -s "${NVM_DIR}/nvm.sh" ] && source "${NVM_DIR}/nvm.sh"

echo "Nvm installed."

# 根据用户选项设置 node 镜像源
case "${NODE_MIRROR}" in
"tsinghua")
  export NVM_NODEJS_ORG_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/
  ;;
"ustc")
  export NVM_NODEJS_ORG_MIRROR=https://mirrors.ustc.edu.cn/node/
  ;;
"aliyun")
  export NVM_NODEJS_ORG_MIRROR=https://mirrors.aliyun.com/nodejs-release/
  ;;
"nju")
  export NVM_NODEJS_ORG_MIRROR=https://mirror.nju.edu.cn/nodejs-release/
  ;;
*)
  echo "Invalid mirror option: ${MIRROR}"
  exit 1
  ;;
esac

# Adjust node version if required
if [ "${NODE_VERSION}" = "none" ]; then
  NODE_VERSION=
elif [ "${NODE_VERSION}" = "lts" ]; then
  NODE_VERSION="lts/*"
elif [ "${NODE_VERSION}" = "latest" ]; then
  NODE_VERSION="node"
fi

nvm install $NODE_VERSION
if [ "${NODE_VERSION}" != "" ]; then
  nvm alias default "${NODE_VERSION}"
  nvm use $NODE_VERSION
fi

# 根据用户选项设置 npm 镜像源
case "${NPM_MIRROR}" in
"tencent")
  npm config set registry http://mirrors.tencent.com/npm/
  ;;
"ustc")
  npm config set registry https://npmreg.proxy.ustclug.org/
  ;;
"aliyun")
  npm config set registry https://registry.npmmirror.com
  ;;
"nju")
  npm config set registry https://repo.nju.edu.cn/repository/npm/
  ;;
*)
  echo "Invalid mirror option: ${MIRROR}"
  exit 1
  ;;
esac

# 安装 pnpm
npm install -g @pnpm/exe

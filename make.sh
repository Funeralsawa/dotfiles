#! /bin/bash

#安装依赖
apt update
apt install build-essential
apt install git
apt install wget
apt install curl

#创建临时文件夹
mkdir test
cd test
git clone git@github.com:neovim/neovim.git
make CMAKE_BUILD_TYPE=RelWithDebInfo
make install

cd ..

# 同步bashrc, tmux.conf
rm ~/.bashrc
rm ~/.tmux.conf

# XDG 环境变量
export XDG_CONFIG_HOME=$HOME/dotfiles/config
export XDG_DATA_HOME=$HOME/dotfiles/data
export XDG_CACHE_HOME=$HOME/dotfiles/cache

# 创建符号链接
ln -sf $XDG_CONFIG_HOME/bash/.bashrc ~/.bashrc
ln -sf $XDG_CONFIG_HOME/tmux/.tmux.conf ~/.tmux.conf

source ~/.bashrc

echo "Dotfiles 已迁移并与 XDG 配置同步。"

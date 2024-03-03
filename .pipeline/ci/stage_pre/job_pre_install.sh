#!/bin/sh

# complete the installation of all dependencies
echo "1. apt-get update && apt-get install -y curl"
sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak \
    && sudo echo 'deb http://mirrors.163.com/debian/ stretch main non-free contrib' > /etc/apt/sources.list \
    && sudo echo 'deb http://mirrors.163.com/debian/ stretch-updates main non-free contrib' >> /etc/apt/sources.list \
    && sudo echo 'deb http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib' >> /etc/apt/sources.list \
    && apt-get update -y
apt-get install curl -y

# if trigger cmd exists, then execute it.
if [ "${global_trigger_cmd}" != "" ]; then
    if ! eval "${global_trigger_cmd}"; then
        exit 1
    fi
fi

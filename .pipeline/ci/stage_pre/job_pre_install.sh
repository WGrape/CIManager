#!/bin/sh

# complete the installation of all dependencies
echo "1. change apt resource"
mv /etc/apt/sources.list /etc/apt/sources.list.bak \
    && echo 'deb http://mirrors.163.com/debian/ stretch main non-free contrib' > /etc/apt/sources.list \
    && echo 'deb http://mirrors.163.com/debian/ stretch-updates main non-free contrib' >> /etc/apt/sources.list \
    && echo 'deb http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib' >> /etc/apt/sources.list \
    && apt-get update -y

echo "2. install curl"
apt-get install curl -y

echo "3. install docker and docker-compose"
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
curl -L https://github.com/docker/compose/releases/download/1.3.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
which docker
which docker-compose

# if trigger cmd exists, then execute it.
if [ "${global_job_cmd}" != "" ]; then
    if ! eval "${global_job_cmd}"; then
        exit 1
    fi
fi

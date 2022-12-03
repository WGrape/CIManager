currentDir=$(pwd)
. $currentDir/.gitlab/include/function.sh

echo -e "------------ The script pre_install.sh is running ------------"

EveryStageCommonOperation

# Complete the installation of all dependencies
echo -e "1. apt-get update && apt-get install -y curl"
mv /etc/apt/sources.list /etc/apt/sources.list.bak \
    && echo 'deb http://mirrors.163.com/debian/ stretch main non-free contrib' > /etc/apt/sources.list \
    && echo 'deb http://mirrors.163.com/debian/ stretch-updates main non-free contrib' >> /etc/apt/sources.list \
    && echo 'deb http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib' >> /etc/apt/sources.list \
    && apt-get update -y
apt-get install curl -y

echo -e "------------ The script pre_install.sh is stopped ------------"

currentDir=$(pwd)
. $currentDir/.gitlab/include/function.sh
echo -e "------------ The script pre_install.sh is running ------------"
echo -e "1. Print the variables"
PrintEnv

# Complete the installation of all dependencies
echo -e "2. apt-get update && apt-get install -y curl"
apt-get update
apt-get install -y curl
#apt-get install -y curl

echo -e "------------ The script pre_install.sh is stopped ------------"


echo -e "------------ The script print_env.sh is running ------------"

echo -e "1. Print the environment of golang"
go version && go env -w GO111MODULE=off && go env

echo -e "2. Print the system variables"
echo -e "GOPATH="$GOPATH
echo -e "PROJECT_PATH="$PROJECT_PATH

echo -e "3. Print the directories"
echo -e "pwd="$(pwd)
echo -e "ls="$(ls)

echo -e "------------ The script print_env.sh is stopped ------------"

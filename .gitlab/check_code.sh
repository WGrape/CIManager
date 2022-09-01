currentDir=$(pwd)
. $currentDir/.gitlab/include/function.sh
echo -e "------------ The script check_code.sh is running ------------"
echo -e "1. Print the variables"
PrintEnv

which "$(go env GOPATH)/bin/golangci-lint" >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo -e "2. command golangci-lint not exist, installing it ..."
  echo -e "2.1 git clone https://github.com/WGrape/cache.git && cd cache/golangci-lint && chmod 777 golangci-lint && cp golangci-lint $(go env GOPATH)/bin/ && cd $currentDir && rm -rf ./cache && ls"
  git clone https://github.com/WGrape/cache.git && cd cache/golangci-lint && chmod 777 golangci-lint && cp golangci-lint $(go env GOPATH)/bin/ && cd $currentDir && rm -rf ./cache && ls -alh
else
  echo -e "2. golangci-lint is installed"
fi

echo "3." $($(go env GOPATH)/bin/golangci-lint --version)
$(go env GOPATH)/bin/golangci-lint --version

echo "4." $(go env GOPATH)/bin/golangci-lint run --timeout=10m
if [ $? -ne 0 ]; then
  FAILURE_REASON="Failed to run check_code.sh: check failed"
  SendFailureNotice
  exit 1
fi

echo "5. golangci-lint check passed"

echo -e "------------ The script check_code.sh is stopped ------------"
# binary will be $(go env GOPATH)/bin/golangci-lint
# curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.46.2
currentDir=$(pwd)
. $currentDir/.gitlab/include/function.sh
echo -e "------------ The script check_code.sh is running ------------"
echo -e "1. Print the variables"
PrintEnv

# 2. Check the golangci-lint is exist
which "$(go env GOPATH)/bin/golangci-lint" >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo -e "2. command golangci-lint not exist, installing it ..."
  echo -e "2.1 curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.46.2"
  curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.46.2
else
  echo -e "2. golangci-lint is installed"
fi

# 3. Check the golangci-lint version
echo "3." $($(go env GOPATH)/bin/golangci-lint --version)

# 4. Run the golangci-lint
$(go env GOPATH)/bin/golangci-lint run --timeout=10m
if [ $? -ne 0 ]; then
  FAILURE_REASON="代码检查失败(check_code.sh)"
  SendFailureNotice
  echo -e " >>>>>>>>>>>> Sorry, check code failed <<<<<<<<<<<<"
  exit 1
fi
echo "4. golangci-lint check passed"

echo -e "------------ The script check_code.sh is stopped ------------"
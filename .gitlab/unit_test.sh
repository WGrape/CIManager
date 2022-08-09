currentDir=$(pwd)
. $currentDir/.gitlab/include/function.sh
echo -e "------------ The script unit_test.sh is running ------------"
echo -e "1. Print the variables"
PrintEnv

# 1. Test the directory of utils
echo "1. test the directory of utils"
cd utils && go test -v . && cd $currentDir
if [ $? -ne 0 ]; then
  FAILURE_REASON="单元测试失败(unit_test.sh)"
  echo -e " >>>>>>>>>>>> Sorry, unit test failed <<<<<<<<<<<<"
  SendFailureNotice
  exit 1
fi

echo -e "------------ The script unit_test.sh is stopped ------------"

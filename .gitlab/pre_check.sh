currentDir=$(pwd)
. $currentDir/.gitlab/include/function.sh
echo -e "------------ The script pre_check.sh is running ------------"
echo -e "1. Print the variables"
PrintEnv

echo -e "2. Check the variables"
if [ "$UNIT_TEST_TRIGGER_CMD" == "" ] ; then
  FAILURE_REASON="预检查失败(pre_check.sh)"
  echo -e " >>>>>>>>>>>> Sorry, check variables failed <<<<<<<<<<<<"
  SendFailureNotice
  exit 1
fi

echo -e "------------ The script pre_install.sh is stopped ------------"

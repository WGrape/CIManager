currentDir=$(pwd)
. $currentDir/.gitlab/include/function.sh
echo -e "------------ The script unit_test.sh is running ------------"
echo -e "1. Print the variables"
PrintEnv

# 2. Test the directory of dao
echo "2. Trigger the unit test"
eval $UNIT_TEST_TRIGGER_CMD
if [ $? -ne 0 ]; then
  FAILURE_REASON="Failed to run unit_test.sh: test failed"
  SendFailureNotice
  exit 1
fi

echo -e "------------ The script unit_test.sh is stopped ------------"

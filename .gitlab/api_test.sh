currentDir=$(pwd)
. $currentDir/.gitlab/include/function.sh
echo -e "------------ The script api_test.sh is running ------------"

EveryStageCommonOperation

if [ "${API_TEST_SWITCH}" == "" ] || [ "${API_TEST_SWITCH}" == "off" ] ; then
  echo -e "Because you turn off the switch, so skip api_test.sh"
  exit 0
fi

eval $API_TEST_TRIGGER_CMD
if [ $? -ne 0 ]; then
  FAILURE_REASON="run API Test failed"
  SendFailureNotice
  exit 1
else
  echo -e "run API Test success"
fi

echo -e "------------ The script api_test.sh is stopped ------------"

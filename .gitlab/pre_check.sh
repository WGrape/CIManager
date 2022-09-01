currentDir=$(pwd)
. $currentDir/.gitlab/include/function.sh
echo -e "------------ The script pre_check.sh is running ------------"
echo -e "1. Print the variables"
PrintEnv

echo -e "2. Check the variables"
if [ "$UNIT_TEST_TRIGGER_CMD" == "" ] ; then
  FAILURE_REASON="Failed to run pre_check.sh: the variables UNIT_TEST_TRIGGER_CMD empty"
  SendFailureNotice
  exit 1
fi

if [ "$APIDOC_TRIGGER_CMD" == "" ] ; then
  FAILURE_REASON="Failed to run pre_check.sh: the variables APIDOC_TRIGGER_CMD empty"
  SendFailureNotice
  exit 1
fi

if [ "$APIDOC_FILE" == "" ] ; then
  FAILURE_REASON="Failed to run pre_check.sh: the variables APIDOC_FILE empty"
  SendFailureNotice
  exit 1
fi

echo -e "------------ The script pre_install.sh is stopped ------------"

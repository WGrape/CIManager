currentDir=$(pwd)
. $currentDir/.gitlab/include/function.sh
echo -e "------------ The script pre_check.sh is running ------------"
echo -e "1. Print the variables"
PrintEnv

echo -e "2. Check the must variables"

if [ "${LOCAL_BUILD_TRIGGER_CMD}" == "" ] ; then
  FAILURE_REASON="Failed to run pre_check.sh: the variables LOCAL_BUILD_TRIGGER_CMD empty"
  SendFailureNotice
  exit 1
fi

if [ "${HEALTH_CHECK_TRIGGER_CMD}" == "" ] ; then
  FAILURE_REASON="Failed to run pre_check.sh: the variables HEALTH_CHECK_TRIGGER_CMD empty"
  SendFailureNotice
  exit 1
fi

if [ "${HEALTH_CHECK_SUCCESS}" == "" ] ; then
  FAILURE_REASON="Failed to run pre_check.sh: the variables HEALTH_CHECK_SUCCESS empty"
  SendFailureNotice
  exit 1
fi

echo -e "------------ The script pre_install.sh is stopped ------------"

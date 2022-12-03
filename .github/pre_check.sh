currentDir=$(pwd)
. $currentDir/.github/include/function.sh
echo -e "------------ The script pre_check.sh is running ------------"
echo -e "1. Print the variables"
PrintEnv

echo -e "2. Check the must variables"

if [ "${DING_NOTICE_SWITCH}" == "on" ]; then
  if [ "${DING_ACCESS_TOKEN}" == "" ]; then
    FAILURE_REASON="Failed to run pre_check.sh: the variables DING_ACCESS_TOKEN empty"
    SendFailureNotice
    exit 1
  fi
fi

if [ "${UNIT_TEST_SWITCH}" == "on" ]; then
  if [ "${UNIT_TEST_TRIGGER_CMD}" == "" ]; then
    FAILURE_REASON="Failed to run pre_check.sh: the variables UNIT_TEST_TRIGGER_CMD empty"
    SendFailureNotice
    exit 1
  fi
fi

if [ "${APIDOC_SWITCH}" == "on" ]; then
  if [ "${APIDOC_TRIGGER_CMD}" == "" ] || [ "${APIDOC_FILE}" == "" ] ; then
    FAILURE_REASON="Failed to run pre_check.sh: the variables APIDOC_TRIGGER_CMD/APIDOC_FILE empty"
    SendFailureNotice
    exit 1
  elif [ "${GITHUB_HOST}" == "" ] || [ "${GITHUB_API_TOKEN}" == "" ] || [ "${PROJECT_ID}" == "" ] ; then
    FAILURE_REASON="Failed to run pre_check.sh: the variables GITHUB_HOST/GITHUB_API_TOKEN/PROJECT_ID empty"
    SendFailureNotice
    exit 1
  fi
fi

if [ "${LOCAL_BUILD_SWITCH}" == "on" ]; then
  if [ "${LOCAL_BUILD_TRIGGER_CMD}" == "" ] ; then
    FAILURE_REASON="Failed to run pre_check.sh: the variables LOCAL_BUILD_TRIGGER_CMD empty"
    SendFailureNotice
    exit 1
  fi
fi

if [ "${HEALTH_CHECK_SWITCH}" == "on" ]; then
  if [ "${HEALTH_CHECK_TRIGGER_CMD}" == "" ] || [ "${HEALTH_CHECK_SUCCESS}" == "" ] ; then
    FAILURE_REASON="Failed to run pre_check.sh: the variables HEALTH_CHECK_TRIGGER_CMD/HEALTH_CHECK_SUCCESS empty"
    SendFailureNotice
    exit 1
  fi
fi

echo -e "------------ The script pre_check.sh is stopped ------------"

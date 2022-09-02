currentDir=$(pwd)
. $currentDir/.gitlab/include/function.sh
echo -e "------------ The script health_check.sh is running ------------"
echo -e "1. Print the variables"
PrintEnv

if [ "${HEALTH_CHECK_TRIGGER_CMD}" != "" ]; then
    res=$(eval $UNIT_TEST_TRIGGER_CMD)
    if [ "${res}" != "${HEALTH_CHECK_SUCCESS}" ]; then
        FAILURE_REASON="Failed to run health_check.sh: res not success, real=${res}"
        SendFailureNotice
      exit 1
    fi
fi

echo -e "------------ The script health_check.sh is stopped ------------"

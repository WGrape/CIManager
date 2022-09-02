currentDir=$(pwd)
. $currentDir/.gitlab/include/function.sh
echo -e "------------ The script health_check.sh is running ------------"
echo -e "1. Print the variables"
PrintEnv

echo -e "2. Check the service"
if [ "${HEALTH_CHECK_TRIGGER_CMD}" != "" ]; then
    i=0
    while true
    do
        ((i++))

        res=$(eval $HEALTH_CHECK_TRIGGER_CMD)
        if [ "${res}" == "${HEALTH_CHECK_SUCCESS}" ]; then
            echo -e "health check success"
            break
        fi

        if [ $i -ge 100 ]; then
            FAILURE_REASON="Failed to run health_check.sh: res not success, real=${res}"
            SendFailureNotice
            exit 1
        fi

        sleep 1
    done
fi

echo -e "------------ The script health_check.sh is stopped ------------"

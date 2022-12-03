currentDir=$(pwd)
. $currentDir/.gitlab/include/function.sh
echo -e "------------ The script api_test.sh is running ------------"

EveryStageCommonOperation

if [ "${API_TEST_TRIGGER_CMD}" != "" ]; then
    eval $API_TEST_TRIGGER_CMD
    if [ $? -ne 0 ]; then
        FAILURE_REASON="run API Test failed"
        SendFailureNotice
        exit 1
    else
        echo -e "run API Test success"
    fi
else
    echo -e "No variable configurations for api test"
fi

echo -e "------------ The script api_test.sh is stopped ------------"

currentDir=$(pwd)
. $currentDir/.gitlab/include/function.sh

echo -e "------------ The script unit_test.sh is running ------------"

EveryStageCommonOperation

# 1. Test the directory of dao
echo -e "1. Trigger the unit test"
if [ "${UNIT_TEST_TRIGGER_CMD}" != "" ]; then
    eval $UNIT_TEST_TRIGGER_CMD
    if [ $? -ne 0 ]; then
        FAILURE_REASON="Failed to run unit_test.sh: test failed"
        SendFailureNotice
        exit 1
    else
        echo -e "test success"
    fi
else
    echo -e "No variable configurations for unit test"
fi

echo -e "------------ The script unit_test.sh is stopped ------------"

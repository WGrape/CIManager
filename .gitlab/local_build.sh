currentDir=$(pwd)
. $currentDir/.gitlab/include/function.sh
echo -e "------------ The script local_build.sh is running ------------"
echo -e "1. Print the variables"
PrintEnv

echo -e "2. Build the project at local"
if [ "${LOCAL_BUILD_TRIGGER_CMD}" != "" ]; then
    eval $LOCAL_BUILD_TRIGGER_CMD
    if [ $? -ne 0 ]; then
        FAILURE_REASON="Failed to run local_build.sh: build failed"
        SendFailureNotice
        exit 1
    else
        echo -e "build success"
    fi
fi

echo -e "------------ The script local_build.sh is stopped ------------"

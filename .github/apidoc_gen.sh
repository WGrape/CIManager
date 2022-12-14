currentDir=$(pwd)
. $currentDir/.github/include/function.sh

echo -e "------------ The script apidoc_gen.sh is running ------------"

EveryStageCommonOperation

echo -e "1. generate apidoc"
if [ "${APIDOC_TRIGGER_CMD}" != "" ] && [ "${APIDOC_FILE}" != "" ]; then
    echo -e "1.1 ${APIDOC_TRIGGER_CMD} && cd $currentDir"
    eval $APIDOC_TRIGGER_CMD && cd $currentDir

    echo -e "1.2 cat ${APIDOC_FILE}"
    content=$(cat $APIDOC_FILE)
    if [ "${content}" == "" ]; then
        FAILURE_REASON="Failed to run apidoc_gen.sh: content empty"
        SendFailureNotice
        exit 1
    fi

    echo -e "2.3. put github wiki: since the official website does not provide the GitHub wiki API, it cannot be updated to the wiki, please ignore this issue"
else
    echo -e "No variable configurations for apidoc generate"
fi

echo -e "------------ The script apidoc_gen.sh is stopped ------------"

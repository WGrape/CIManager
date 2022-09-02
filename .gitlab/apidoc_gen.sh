currentDir=$(pwd)
. $currentDir/.gitlab/include/function.sh
echo -e "------------ The script apidoc_gen.sh is running ------------"
echo -e "1. Print the variables"
PrintEnv

echo -e "2. generate apidoc"
if [ "${APIDOC_TRIGGER_CMD}" != "" ] && [ "${APIDOC_FILE}" != "" ]; then
    echo -e "2.1 ${APIDOC_TRIGGER_CMD} && cd $currentDir"
    eval $APIDOC_TRIGGER_CMD && cd $currentDir

    echo -e "2.2 cat ${APIDOC_FILE}"
    content=$(cat $APIDOC_FILE)
    if [ "${content}" == "" ]; then
        FAILURE_REASON="Failed to run apidoc_gen.sh: content empty"
        SendFailureNotice
        exit 1
    fi

    echo -e "2.3. put gitlab wiki"
    if [ "${GITLAB_HOST}" != "" ] && [ "${GITLAB_API_TOKEN}" != "" ] && [ "${PROJECT_ID}" != "" ]; then
        curl --request PUT --data "format=markdown&content=${content}&title=APIDoc" \
             --header "PRIVATE-TOKEN: ${GITLAB_API_TOKEN}" "${GITLAB_HOST}/api/v4/projects/${PROJECT_ID}/wikis/APIDoc"
    else
        echo -e "No variable configurations for Gitlab Wiki API"
    fi
else
    echo -e "No variable configurations for apidoc generator"
fi

echo -e "------------ The script apidoc_gen.sh is stopped ------------"

# Print the environment variables.
PrintEnv(){
    echo -e "cat /proc/version="$(cat /proc/version)
    echo -e "CI_BUILDS_DIR=${CI_BUILDS_DIR}"
    echo -e "pwd="$(pwd)
    echo -e "ls="$(ls)
}

# Actions performed by each task
EveryStageCommonOperation(){
    echo -e "[The following are common operations for each task]"
    echo -e "[- Print the variables]"
    PrintEnv
    echo -e "[The above are common operations for each task]"
}

# Send the failure notice.
SendFailureNotice(){
    if [ "${GITHUB_REF_NAME}" == "main" ] || [ "${GITHUB_REF_NAME}" == "master" ] ; then
        actionName="Request to merge ${GITHUB_REF_NAME}"
    elif [ "${GITHUB_REF_NAME}" == "test" ]; then
        actionName="Request to merge test"
    else
        actionName="Commit to ${GITHUB_REF_NAME}"
    fi

    MESSAGE="【${DING_KEYWORD}】CI/CD Failed Notice
    Operation: ${actionName}
    Project: ${GITHUB_REPOSITORY}
    Branch: ${GITHUB_REF_NAME}
    Reason: ${FAILURE_REASON}
    More: ${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}
    made by CIManager
    "
    if [ "${DING_NOTICE_SWITCH}" == "on" ] && [ "${DING_ACCESS_TOKEN}" != "" ] ; then
        curl -H 'Content-type: application/json' -d "{\"msgtype\":\"text\", \"text\": {\"content\":\"${MESSAGE}\"}}" "https://oapi.dingtalk.com/robot/send?access_token=${DING_ACCESS_TOKEN}"
    else
        echo $MESSAGE
    fi
}

# print success message.
print_ok() {
    printf "\033[34m$1\033[0m"
}

# print error message.
print_error() {
    printf "\033[31m$1\033[0m"
}

# print warn message.
print_warn() {
    printf "\e[33m$1\e[0m"
}

# print the environment variables.
print_env(){
    echo "================ [variables] ================"
    echo "1. cat /proc/version="$(cat /proc/version)
    echo "2. CI_BUILDS_DIR=${CI_BUILDS_DIR}"
    echo "3. pwd="$(pwd)
    echo "4. ls="$(ls -alh)
}

# before job
before_job() {
    echo "------------ before the job: ${job_name} ------------"
    print_env
    return 0
}

run_job() {
    echo "------------ running the job: ${job_name} ------------"
    if ! bash "${global_job_path}"; then
        print_error "job fail: ${global_job_name}"
        return 1
    fi
    return 0
}

# after job
after_job() {
    echo "------------ after the job: ${job_name} ------------"
    return 0
}

# send the failure notice.
send_failure_notice(){
    if [ "${CI_COMMIT_REF_NAME}" == "${CI_DEFAULT_BRANCH}" ]; then
        actionName="Request to merge ${CI_COMMIT_REF_NAME}"
    elif [ "${CI_COMMIT_REF_NAME}" == "test" ]; then
        actionName="Request to merge test"
    else
        actionName="Commit to ${CI_COMMIT_REF_NAME}"
    fi

    MESSAGE="【${DING_KEYWORD}】CI/CD Failed Notice
    Operation: ${actionName}
    Project: ${CI_PROJECT_NAME}
    Branch: ${CI_COMMIT_REF_NAME}
    Operator: ${GITLAB_USER_EMAIL}
    Reason: ${FAILURE_REASON}
    More: ${CI_PIPELINE_URL}
    made by CIManager
    "
    if [ "${DING_NOTICE_SWITCH}" == "on" ] && [ "${DING_ACCESS_TOKEN}" != "" ] ; then
        curl -H 'Content-type: application/json' -d "{\"msgtype\":\"text\", \"text\": {\"content\":\"${MESSAGE}\"}}" "https://oapi.dingtalk.com/robot/send?access_token=${DING_ACCESS_TOKEN}"
    else
        echo $MESSAGE
    fi
}

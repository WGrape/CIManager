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

# print step message.
print_step() {
    if [ "$STAGE_ID" = "" ]; then
        STAGE_ID=0
    fi
    ((STAGE_ID++))
    printf "\033[32m\n+++++ step$STAGE_ID: $1 +++++\033[0m\n\n"
}

# print the environment variables.
show_env(){
    print_step "show_env: ${job_name}"
    echo "1. cat /proc/version="$(cat /proc/version)
    echo "2. CI_BUILDS_DIR=${CI_BUILDS_DIR}"
    echo "3. pwd="$(pwd)
    echo "4. ls="$(ls -alh)
}

# before job
before_job() {
    print_step "before the job: ${job_name}"
    show_env
    return 0
}

run_job() {
    print_step "running the job: ${job_name}"
    if ! bash "${global_job_path}"; then
        print_error "job fail: ${global_job_name}"
        return 1
    fi
    return 0
}

# after job
after_job() {
    print_step "after the job: ${job_name}"
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

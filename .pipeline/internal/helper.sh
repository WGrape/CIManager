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
    printf " \e[36m+++++ step$STAGE_ID: $1 +++++\e[0m\n\n"
}

# before job
before_job() {
    print_step "before the job: ${job_name}"
    return 0
}

run_job() {
    print_step "running the job: ${job_name}"
    if ! bash "${global_job_path}"; then
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

    MESSAGE="【Failed】CI/CD Failed Notice
    global_job_name: ${global_job_name}
    global_job_path: ${global_job_path}
    global_switch_name: ${global_switch_name}
    global_trigger_cmd: ${global_trigger_cmd}
    —— made by CIManager
    "
    if [ "${DING_NOTICE_SWITCH}" == "on" ] && [ "${DING_ACCESS_TOKEN}" != "" ] ; then
        curl -H 'Content-type: application/json' -d "{\"msgtype\":\"text\", \"text\": {\"content\":\"${MESSAGE}\"}}" "https://oapi.dingtalk.com/robot/send?access_token=${DING_ACCESS_TOKEN}"
    else
        echo $MESSAGE
    fi
}

# print success message.
print_ok() {
    printf "\033[32m$1\033[0m"
}

# print error message.
print_error() {
    printf "\033[31m$1\033[0m"
}

# print warn message.
print_warn() {
    printf "\e[33m$1\e[0m"
}

# print phase message.
print_phase() {
    if [ "$PHASE_ID" = "" ]; then
        PHASE_ID=0
    fi
    ((PHASE_ID++))
    printf "\n\n\e[36m+++++ Phase$PHASE_ID: $1 +++++\e[0m\n\n"
}

# print step message.
print_step() {
    if [ "$STAGE_ID" = "" ]; then
        STAGE_ID=0
    fi
    ((STAGE_ID++))
    printf "\n\n\033[34m----- Step($STAGE_ID): $1 -----\e[0m\n\n"
}

# before job
before_job() {
    print_step "before the job: ${global_job_name}"
    return 0
}

# run job
run_job() {
    print_step "running the job: ${global_job_name}"
    if ! . "${global_job_path}"; then
        return 1
    fi
    return 0
}

# after job
after_job() {
    print_step "after the job: ${global_job_name}"
    return 0
}

# send the failure notice.
send_failure_notice(){
    MESSAGE="【Failed】CI/CD Failed Notice
    global_job_name: ${global_job_name}
    global_job_path: ${global_job_path}
    global_job_switch_name: ${global_job_switch_name}
    global_job_cmd: ${global_job_cmd}
    —— made by CIManager
    "
    echo $MESSAGE
}

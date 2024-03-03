#!/bin/sh

CUR_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)
cd $CUR_PATH && cd ../
BASE_PATH=$(pwd)
. $BASE_PATH/.pipeline/internal/helper.sh

job_queue=(
    # ========================= CI =========================
    # [stage] = pre
    "ci.stage_pre.job_pre_check"
    "ci.stage_pre.job_pre_install"

    # [stage] = test
    "ci.stage_test.job_check_code"
    "ci.stage_test.job_unit_test"

    # [stage] = build
    "ci.stage_build.job_local_build"
    "ci.stage_build.job_apidoc_gen"
    # ========================= CD =========================
    # [stage] = deploy
    # "cd.stage_deploy.job_pull_artifact"
    "cd.stage_deploy.job_ssh"
    # [stage] = monitor
    "cd.stage_monitor.job_api_test"
    "cd.stage_monitor.job_health_check"
)

for job_name in "${job_queue[@]}"; do
    global_job_name=${job_name//./_}
    global_job_path="${BASE_PATH}/.pipeline/${job_name//./\/}.sh"
    global_switch_name="${global_job_name^^}_SWITCH" # ^^ equals upper()
    global_trigger_cmd="${global_job_name^^}_TRIGGER_CMD"

    print_step "handle job: ${global_job_name}"

    # check if the switch is on
    switch_status=$(eval echo "$"$global_switch_name)
    if [ "${switch_status}" != "ON" ]; then
        print_warn "job is skipped, due to the switch(${global_switch_name}) is off\n"
        continue
    fi

    # before job
    if ! before_job; then
        print_error "pipline exit, before_job failed: ${global_job_name}\n"
        exit 1
    fi

    # run job
    if ! run_job; then
        print_error "pipline exit, run_job failed: ${global_job_name}\n"
        send_failure_notice
        exit 1
    fi

    # after job
    if ! after_job; then
        print_error "pipline exit, after_job failed: ${global_job_name}\n"
        exit 1
    fi
done

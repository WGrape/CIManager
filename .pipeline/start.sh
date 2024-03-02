#!/bin/sh

CUR_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)
cd $CUR_PATH && cd ../
BATH_PATH=$(pwd)
. $BATH_PATH/internal/helper.sh

job_queue = (
    # ========================= CI =========================
    # [stage] = pre
    "ci.stage_pre.job_pre_check"
    "ci.stage_pre.job_pre_install"

    # [stage] = test
    "ci.stage_test.job_check_code"
    "ci.stage_test.job_unit_test"

    # [stage] = build
    "ci.stage_build.job_apidoc_gen"
    "ci.stage_build.job_local_build"
    # ========================= CD =========================
    # [stage] = deploy
    "cd.stage_deploy.job_ssh"  # "cd.stage_deploy.job_pull_artifact"
    # [stage] = monitor
    "cd.stage_monitor.job_api_test"
    "cd.stage_monitor.job_health_check"
)

for job_name in "${job_queue[@]}"; do
    global_job_name=${job_name}
    global_job_path="${job_name//./\/}.sh"
    global_switch_name="${job_name^^}_SWITCH"
    global_trigger_cmd="${job_name^^}_TRIGGER_CMD"

    # check if the switch is on
    if [ ${!global_switch_name} != "true" ]; then
        print_ok "${global_job_name} is skipped due to the switch is off"
        continue
    fi

    # before job
    if ! before_job; then
        print_error "pipline exit, before_job failed: ${global_job_name}"
        exit 1
    fi

    # run job
    if ! run_job; then
        print_error "pipline exit, run_job failed: ${global_job_path} failed"
        exit 1
    fi

    # after job
    if ! after_job; then
        print_error "pipline exit, after_job failed: ${global_job_name}"
        exit 1
    fi
done
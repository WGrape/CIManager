#!/bin/sh

CUR_PATH=$(cd "$(dirname "$0")" && pwd)
cd $CUR_PATH && cd ../
BASE_PATH=$(pwd)
. $BASE_PATH/.pipeline/internal/helper.sh

printf "================ Debug Start ================\n\n"
show_env(){
  echo "1. cat /proc/version="$(cat /proc/version)
  echo "2. pwd="$(pwd)
  echo "3. ls="$(ls -a)
}
show_env
printf "================ End Debug ================\n\n"

printf "\e[36m>>>>>>>>>>> Start Pipeline\e[0m\n\n"

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
    "cd.stage_deploy.job_ssh"
    "cd.stage_deploy.job_launch"
    # [stage] = monitor
    "cd.stage_monitor.job_api_test"
    "cd.stage_monitor.job_health_check"
)
if [ "$1" == "" ]; then
    job_queue=($1)
fi

for job_name in "${job_queue[@]}"; do
    global_job_name=${job_name//./_}
    global_job_path="${BASE_PATH}/.pipeline/${job_name//./\/}.sh"
    global_job_switch_name="${global_job_name^^}_SWITCH" # ^^ equals upper()
    global_job_cmd_name="${global_job_name^^}_CMD"
    global_job_cmd=${!global_job_cmd_name}

    print_phase "handle job: ${global_job_name}"

    # check if the switch is on
    switch_status=${!global_job_switch_name}
    if [ "${switch_status}" != "ON" ]; then
        print_warn "job is skipped, due to the switch(${global_job_switch_name}=${switch_status}) is off\n\n"
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

printf "\e[36m<<<<<<<<<<< End Pipeline\e[0m"
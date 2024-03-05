#!/bin/sh

# if trigger cmd exists, then execute it.
if [ "${global_job_cmd}" != "" ]; then
    i=0
    while true
    do
        ((i++))

        # res=$(eval $global_job_cmd)
        res=`eval $global_job_cmd`
        if [ "${res}" == "${CD_STAGE_MONITOR_JOB_HEALTH_CHECK_CMD_RES}" ]; then
            echo "health check success"
            break
        fi

        if [ $i -ge 10 ]; then
            echo "health check failed: res=${res}, except=${CD_STAGE_MONITOR_JOB_HEALTH_CHECK_CMD_RES}"
            exit 1
        fi

        sleep 1
    done
fi

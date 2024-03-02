#!/bin/sh

# if trigger cmd exists, then execute it.
if [ "${global_trigger_cmd}" != "" ]; then
    if ! eval "${global_trigger_cmd}"; then
        FAILURE_REASON="failed to run ${global_job_name}"
        send_failure_notice
        exit 1
    fi
fi


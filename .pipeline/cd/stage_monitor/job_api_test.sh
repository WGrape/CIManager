#!/bin/sh

# if trigger cmd exists, then execute it.
if [ "${global_job_cmd}" != "" ]; then
    if ! eval "${global_job_cmd}"; then
        exit 1
    fi
fi


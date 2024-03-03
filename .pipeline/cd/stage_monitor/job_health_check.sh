#!/bin/sh

# if trigger cmd exists, then execute it.
if [ "${global_trigger_cmd}" != "" ]; then
    i=0
    while true
    do
        ((i++))

        res=$(eval $global_trigger_cmd)
        if [ "${res}" == "${global_trigger_cmd_res}" ]; then
            echo "health check success"
            break
        fi

        if [ $i -ge 10 ]; then
            exit 1
        fi

        sleep 1
    done
fi

#!/bin/sh

# if trigger cmd exists, then execute it.
if [ "${global_trigger_cmd}" != "" ]; then
    if ! eval "${global_trigger_cmd}"; then
        exit 1
    fi
fi

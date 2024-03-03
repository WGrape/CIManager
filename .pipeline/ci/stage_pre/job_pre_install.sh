#!/bin/sh

# complete the installation of all dependencies
cmd="apt-get update -y && apt-get install curl -y"
echo "1. ${cmd}"
eval $cmd

# if trigger cmd exists, then execute it.
if [ "${global_trigger_cmd}" != "" ]; then
    if ! eval "${global_trigger_cmd}"; then
        exit 1
    fi
fi

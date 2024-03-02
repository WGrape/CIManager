#!/bin/sh

# complete the installation of all dependencies
echo "1. apt-get update && apt-get install -y curl"
mv /etc/apt/sources.list /etc/apt/sources.list.bak \
    && echo 'deb http://mirrors.163.com/debian/ stretch main non-free contrib' > /etc/apt/sources.list \
    && echo 'deb http://mirrors.163.com/debian/ stretch-updates main non-free contrib' >> /etc/apt/sources.list \
    && echo 'deb http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib' >> /etc/apt/sources.list \
    && apt-get update -y
apt-get install curl -y

# if trigger cmd exists, then execute it.
if [ "${global_trigger_cmd}" != "" ]; then
    if ! eval "${global_trigger_cmd}"; then
        FAILURE_REASON="failed to run ${global_job_name}"
        send_failure_notice
        return 1
    fi
fi

return 0

#!/bin/sh

CUR_PATH=$(cd "$(dirname "$0")" && pwd)
cd $CUR_PATH
BASE_PATH=$(pwd)

cp -anr ${BASE_PATH}/.pipeline ${BASE_PATH}/../
cd ${BASE_PATH}/../

rm -rf ./CIManager

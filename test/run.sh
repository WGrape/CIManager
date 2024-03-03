#!/bin/sh

CUR_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)
cd $CUR_PATH && cd ../
BASE_PATH=$(pwd)
. $BASE_PATH/.pipeline/internal/helper.sh

echo "test start"

echo "end test"

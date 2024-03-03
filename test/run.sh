#!/bin/sh

CUR_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)
cd $CUR_PATH && cd ../
BASE_PATH=$(pwd)
. $BASE_PATH/.pipeline/internal/helper.sh

echo "test start"

print_ok "test print_ok"

print_error "test print_error"

print_warn "test print_warn"

print_phase "test print_phase"

print_step "test print_step"

echo "end test"

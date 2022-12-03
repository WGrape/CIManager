ci_directory=".gitlab"
if [ -n "$1" ] && [ "$1" == "github" ]; then
  ci_directory=".github"
fi

bash ${ci_directory}/pre_check.sh
if [ $? -ne 0 ]; then
    echo -e "
    CIManager Running Result: pre_check.sh failed"
    exit 1
fi

bash ${ci_directory}/pre_install.sh
if [ $? -ne 0 ]; then
    echo -e "
    CIManager Running Result: pre_install.sh failed"
    exit 1
fi

# run check_code.sh
if [ "${CHECK_CODE_SWITCH}" == "on" ]; then
    bash ./${ci_directory}/check_code.sh
    if [ $? -ne 0 ]; then
        echo -e "
        CIManager Running Result: check_code.sh failed"
        exit 1
    fi
else
    echo "apidoc_gen.sh is skipped due to the switch is off"
fi

# run unit_test.sh
if [ "${UNIT_TEST_SWITCH}" == "on" ]; then
    bash ./${ci_directory}/unit_test.sh
    if [ $? -ne 0 ]; then
        echo -e "
        CIManager Running Result: unit_test.sh failed"
        exit 1
    fi
else
    echo "unit_test.sh is skipped due to the switch is off"
fi

# run apidoc_gen.sh
if [ "${APIDOC_SWITCH}" == "on" ]; then
    bash ./${ci_directory}/apidoc_gen.sh
    if [ $? -ne 0 ]; then
        echo -e "
        CIManager Running Result: apidoc_gen.sh failed"
        exit 1
    fi
else
    echo "apidoc_gen.sh is skipped due to the switch is off"
fi

# run local_build.sh
if [ "${LOCAL_BUILD_SWITCH}" == "on" ]; then
    bash ./${ci_directory}/local_build.sh
    if [ $? -ne 0 ]; then
        echo -e "
        CIManager Running Result: local_build.sh failed"
        exit 1
    fi
else
    echo "local_build.sh is skipped due to the switch is off"
fi

# run health_check.sh
if [ "${HEALTH_CHECK_SWITCH}" == "on" ]; then
    bash ./${ci_directory}/health_check.sh
    if [ $? -ne 0 ]; then
        echo -e "
        CIManager Running Result: health_check.sh failed"
        exit 1
    fi
else
    echo "health_check.sh is skipped due to the switch is off"
fi

# run api_test.sh
if [ "${API_TEST_SWITCH}" == "on" ]; then
    bash ./${ci_directory}/api_test.sh
    if [ $? -ne 0 ]; then
        echo -e "
        CIManager Running Result: api_test.sh failed"
        exit 1
    fi
else
    echo "api_test.sh is skipped due to the switch is off"
fi

echo -e "
CIManager Running Result: success"

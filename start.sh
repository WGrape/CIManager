bash .gitlab/pre_check.sh
if [ $? -ne 0 ]; then
  echo -e "
CIManager Running Result: pre_check.sh failed"
  exit 1
fi

bash .gitlab/pre_install.sh
if [ $? -ne 0 ]; then
  echo -e "
CIManager Running Result: pre_install.sh failed"
  exit 1
fi

if [ "${CHECK_CODE_SWITCH}" == "on" ]; then
  bash ./.gitlab/check_code.sh
  if [ $? -ne 0 ]; then
    echo -e "
  CIManager Running Result: check_code.sh failed"
    exit 1
  fi
else
  echo "apidoc_gen.sh is skipped due to the switch is off"
fi

if [ "${UNIT_TEST_SWITCH}" == "on" ]; then
  bash ./.gitlab/unit_test.sh
  if [ $? -ne 0 ]; then
    echo -e "
  CIManager Running Result: unit_test.sh failed"
    exit 1
  fi
else
  echo "unit_test.sh is skipped due to the switch is off"
fi

if [ "${APIDOC_SWITCH}" == "on" ]; then
  bash ./.gitlab/apidoc_gen.sh
  if [ $? -ne 0 ]; then
    echo -e "
  CIManager Running Result: apidoc_gen.sh failed"
    exit 1
  fi
else
  echo "apidoc_gen.sh is skipped due to the switch is off"
fi

if [ "${LOCAL_BUILD_SWITCH}" == "on" ]; then
  bash ./.gitlab/local_build.sh
  if [ $? -ne 0 ]; then
    echo -e "
  CIManager Running Result: local_build.sh failed"
    exit 1
  fi
else
  echo "local_build.sh is skipped due to the switch is off"
fi

if [ "${HEALTH_CHECK_SWITCH}" == "on" ]; then
  bash ./.gitlab/health_check.sh
  if [ $? -ne 0 ]; then
    echo -e "
  CIManager Running Result: health_check.sh failed"
    exit 1
  fi
else
  echo "health_check.sh is skipped due to the switch is off"
fi

echo -e "
CIManager Running Result: success"

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

bash ./.gitlab/check_code.sh
if [ $? -ne 0 ]; then
  echo -e "
CIManager Running Result: check_code.sh failed"
  exit 1
fi

bash ./.gitlab/unit_test.sh
if [ $? -ne 0 ]; then
  echo -e "
CIManager Running Result: unit_test.sh failed"
  exit 1
fi

bash ./.gitlab/apidoc_gen.sh
if [ $? -ne 0 ]; then
  echo -e "
CIManager Running Result: apidoc_gen.sh failed"
  exit 1
fi

bash ./.gitlab/local_build.sh
if [ $? -ne 0 ]; then
  echo -e "
CIManager Running Result: local_build.sh failed"
  exit 1
fi

bash ./.gitlab/health_check.sh
if [ $? -ne 0 ]; then
  echo -e "
CIManager Running Result: health_check.sh failed"
  exit 1
fi

echo -e "
CIManager Running Result: success"

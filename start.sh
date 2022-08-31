bash .gitlab/pre_install.sh
if [ $? -ne 0 ]; then
  echo -e "
CIManager执行结果: 未通过(pre_install.sh)"
  exit 1
fi

bash ./.gitlab/check_code.sh
if [ $? -ne 0 ]; then
  echo -e "
CIManager执行结果: 未通过(check_code.sh)"
  exit 1
fi

bash ./.gitlab/unit_test.sh
if [ $? -ne 0 ]; then
  echo -e "
CIManager执行结果: 未通过(unit_test.sh)"
  exit 1
fi

bash ./.gitlab/godep_check.sh
if [ $? -ne 0 ]; then
  echo -e "
CIManager执行结果: 未通过(godep_check.sh)"
  exit 1
fi

bash ./.gitlab/config_check.sh
if [ $? -ne 0 ]; then
  echo -e "
CIManager执行结果: 未通过(config_check.sh)"
  exit 1
fi

bash ./.gitlab/apidoc_gen.sh
if [ $? -ne 0 ]; then
  echo -e "
CIManager执行结果: 未通过(apidoc_gen.sh)"
  exit 1
fi

echo -e "
CIManager执行结果: 通过"

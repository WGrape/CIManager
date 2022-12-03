# 设计原理文档

## 一、项目规范

### 1、变量的检查

> 规则 ：假设B变量依赖A变量，如果定义了A变量，却没有定义B变量，那么变量的检查就需要检查出来这个问题

变量的检查可以提前检查出配置的错误，方便即时纠正和快速定位，它主要定义在```pre_check.sh```脚本中，如下代码所示。

```bash
if [ "${DING_NOTICE_SWITCH}" == "on" ]; then
  if [ "${DING_ACCESS_TOKEN}" == "" ]; then
    FAILURE_REASON="Failed to run pre_check.sh: the variables DING_ACCESS_TOKEN empty"
    SendFailureNotice
    exit 1
  fi
fi
```

简单说如果不定义某些变量，会导致系统出错的话，那么这个检查的代码就需要写在这里。当然```pre_check.sh```脚本并不只做变量检查的事情，还有可能包含系统环境检查等操作。

### 2、不同任务的启动

我们把代码检查、单元测试、编译构建等每一个操作定义为在CI/CD中的任务。这些任务的启动，都在```start.sh```脚本中启动，启动条件是用户在配置中手动配置了任务开关为```on```状态，如下代码所示。

```
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
```

### 3、在任务中检查变量

由于可能有单独运行任务的需求，所以为了脚本可以正常执行不出错，即使在```[1,2]```中已经检查了变量，那么在任务脚本中时，仍然要写检查变量是否存在的代码，如下代码所示。

```bash
if [ "${API_TEST_TRIGGER_CMD}" != "" ]; then
  eval $API_TEST_TRIGGER_CMD
  if [ $? -ne 0 ]; then
    FAILURE_REASON="run API Test failed"
    SendFailureNotice
    exit 1
  else
    echo -e "run API Test success"
  fi
fi
```

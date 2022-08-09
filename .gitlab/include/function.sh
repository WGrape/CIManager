SendFailureNotice(){
  mergeTo="test"
  actionName="请求合入test"
  if [ "$CI_COMMIT_REF_NAME" == "$CI_DEFAULT_BRANCH" ]; then
    mergeTo="master"
    actionName="请求合入master"
  fi

  # CI_MERGE_REQUEST_TITLE, CI_MERGE_REQUEST_PROJECT_ID
  MESSAGE="【${DING_NOTICE_KEYWORD}】执行CI自动化失败通知
  操作: ${actionName}
  项目: ${CI_PROJECT_NAME}
  源分支: ${CI_COMMIT_REF_NAME}
  操作人: ${GITLAB_USER_EMAIL}
  失败原因: ${FAILURE_REASON}
  合并标题: ${CI_COMMIT_TITLE}
  合并地址: ${CI_MERGE_REQUEST_SOURCE_PROJECT_URL}/merge_requests
  查看详情: ${CI_PIPELINE_URL}"

  if [ "$CI" == "" ]; then
    echo -e "当前环境不是CI环境，禁止发失败通知"
  else
    curl -H 'Content-type: application/json' -d "{\"msgtype\":\"text\", \"text\": {\"content\":\"${MESSAGE}\"}}" "https://oapi.dingtalk.com/robot/send?access_token=${DING_ACCESS_TOKEN}"
  fi
}

PrintEnv(){
  echo -e "pwd="$(pwd)
  echo -e "ls="$(ls)
}
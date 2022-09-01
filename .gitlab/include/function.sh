SendFailureNotice(){
  if [ "$CI_COMMIT_REF_NAME" == "$CI_DEFAULT_BRANCH" ]; then
      actionName="请求合入$CI_COMMIT_REF_NAME"
  elif [ "$CI_COMMIT_REF_NAME" == "test" ]; then
      actionName="请求合入test"
  else
      actionName="提交至$CI_COMMIT_REF_NAME"
  fi

  # CI_MERGE_REQUEST_TITLE, CI_MERGE_REQUEST_PROJECT_ID
  MESSAGE="【${DING_KEYWORD}】执行CI自动化失败通知
  操作: ${actionName}
  项目: ${CI_PROJECT_NAME}
  源分支: ${CI_COMMIT_REF_NAME}
  操作人: ${GITLAB_USER_EMAIL}
  失败原因: ${FAILURE_REASON}
  查看详情: ${CI_PIPELINE_URL}
  made by CIManager
  "

  echo $MESSAGE
  # curl -H 'Content-type: application/json' -d "{\"msgtype\":\"text\", \"text\": {\"content\":\"${MESSAGE}\"}}" "https://oapi.dingtalk.com/robot/send?access_token=${DING_ACCESS_TOKEN}"
}

PrintEnv(){
  echo -e "pwd="$(pwd)
  echo -e "ls="$(ls)
}
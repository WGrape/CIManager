PrintEnv(){
  echo -e "pwd="$(pwd)
  echo -e "ls="$(ls)
}

SendFailureNotice(){
  if [ "$CI_COMMIT_REF_NAME" == "$CI_DEFAULT_BRANCH" ]; then
      actionName="Request to merge $CI_COMMIT_REF_NAME"
  elif [ "$CI_COMMIT_REF_NAME" == "test" ]; then
      actionName="Request to merge test"
  else
      actionName="Commit to $CI_COMMIT_REF_NAME"
  fi

  MESSAGE="【${DING_KEYWORD}】CI/CD Failed Notice
  Operation: ${actionName}
  Project: ${CI_PROJECT_NAME}
  Branch: ${CI_COMMIT_REF_NAME}
  Operator: ${GITLAB_USER_EMAIL}
  Reason: ${FAILURE_REASON}
  More: ${CI_PIPELINE_URL}
  made by CIManager
  "
  if [ "$DING_NOTICE_SWITCH" == "on" ] && [ "$DING_ACCESS_TOKEN" != "" ] ; then
    curl -H 'Content-type: application/json' -d "{\"msgtype\":\"text\", \"text\": {\"content\":\"${MESSAGE}\"}}" "https://oapi.dingtalk.com/robot/send?access_token=${DING_ACCESS_TOKEN}"
  else
    echo $MESSAGE
  fi
}

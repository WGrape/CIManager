currentDir=$(pwd)
. $currentDir/.gitlab/include/function.sh
echo -e "------------ The script apidoc_gen.sh is running ------------"
echo -e "1. Print the variables"
PrintEnv

#下面是以gitlab为接口文档方式更新的代码
#content=$(cat apidoc.md)
#echo -e "2. cat apidoc.md"
#if [ "${content}" == "" ]; then
#  echo -e "接口文档内容为空或生成失败, 无法自动更新"
#  FAILURE_REASON="接口文档自动生成失败(apidoc_gen.sh)"
#  SendFailureNotice
#  exit 1
#fi
#
#echo -e "3. put gitlab wiki"
## https://docs.gitlab.com/ee/api/wikis.html#edit-an-existing-wiki-page
#curl --request PUT --data "format=markdown&content=${content}&title=APIDoc" \
#     --header "PRIVATE-TOKEN: ${GITLAB_API_TOKEN}" "https://${GITLAB_HOST}/api/v4/projects/${PROJECT_ID}/wikis/APIDoc"

echo -e "------------ The script apidoc_gen.sh is stopped ------------"

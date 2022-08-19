FastCopy(){
  sourceDir=$2
  targetDir=$3
  if [ "$sourceDir" == "" ]; then
    echo "Command fastcopy missed sourceDir"
    exit 1
  fi

  if [ "$targetDir" == "" ]; then
      echo "Command fastcopy missed targetDir"
      exit 1
  fi

  cp -r $sourceDir/.gitlab $targetDir
  cp -r $sourceDir/.gitlab-ci.yml $targetDir
  cp -r $sourceDir/.golangci.yml $targetDir
}

cmd=$1
if [ "$cmd" == "fastcopy" ]; then
  FastCopy
else
  echo -e "Not support cmd: "$cmd
  exit 1
fi

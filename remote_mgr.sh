RunCI(){
  bash .gitlab/mock_ci.sh
}

cmd=$1
if [ "$cmd" == "runci" ]; then
  RunCI
else
  echo -e "Not support cmd: "$cmd
  exit 1
fi

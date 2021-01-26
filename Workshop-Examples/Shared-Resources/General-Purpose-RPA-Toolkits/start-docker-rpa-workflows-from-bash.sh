#! /bin/bash

clear
TIMESTAMP=$(date)


if [ "$1" == "Build-Images-Teardown-Old-Docker-Containers" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  source ./.rpa.env
  echo
  echo "------------------------------------[[[[ Build Images And Teardown Old Docker Containers ]]]]------------------------------------"
  echo
  echo "This will build the Docker images and teardown/remove running containers defined in the docker-compose.yml file. This run started on $TIMESTAMP."
  echo
  docker-compose -f docker-compose.yml down
  docker-compose -f docker-compose.yml rm -f
  docker-compose -f docker-compose.yml build
  docker stop $(docker ps -a -q) 2> /dev/null &&
  docker rm $(docker ps -a -q) 2> /dev/null &&
  docker image prune --force
  TIMESTAMP2=$(date)
  echo "This build ended on $TIMESTAMP2."
fi

if [ "$1" == "RPA-Crypto-Mining-Machines-Parallel-Checker" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  source ./.rpa.env
  echo
  echo
  echo "------------------------------------[[[[ RPA Tool Docker Container - Crypto Mining Machine Checker ]]]]------------------------------------"
  echo
  echo "This Docker Container will run various tools combined with Robot Framework. This run started on $TIMESTAMP."
  echo
  docker-compose -f docker-compose.yml down
  docker-compose -f docker-compose.yml rm -f
  docker-compose -f docker-compose.yml build
  docker-compose run docker-task-runner commands-running-inside-a-docker-container.sh Remote_Crypto_Mining_Machines
  docker stop $(docker ps -a -q) &&
  docker rm $(docker ps -a -q)
  TIMESTAMP2=$(date)
  echo "This test run ended on $TIMESTAMP2."
fi

usage_explanation() {
  echo
  echo
  echo "------------------------------------[[[[ Tool Runner Script ]]]]------------------------------------"
  echo
  echo
  echo "Please read the following to get a full explanation about how this works."
  echo
  echo "https://github.com/jg8481/Tool-Strategies-Lone-Testers-Test-Leadership-Congress-2019/blob/master/README.md"
  echo
  echo "https://github.com/jg8481/Tool-Strategies-Lone-Testers-Test-Leadership-Congress-2019/blob/master/Test_Tool_Strategies_For_Lone_Testers.pdf"
  echo
  echo
}

error_handler() {
  local error_message="$@"
  echo "${error_message}" 1>&2;
}

argument="$1"
if [[ -z $argument ]] ; then
  usage_explanation
else
  case $argument in
    -h|--help)
      usage_explanation
      ;;
    *)
      usage_explanation
      ;;
  esac
fi
#! /bin/bash

clear
TIMESTAMP=$(date)


if [ "$1" == "Build-Images-Teardown-Old-Docker-Containers" ]; then
  source ./.env
  echo
  echo "------------------------------------[[[[ Build Images And Teardown Old Docker Containers ]]]]------------------------------------"
  echo
  echo "This will build the Docker images and teardown/remove running containers defined in the docker-compose.yml file. This run started on $TIMESTAMP."
  echo
  docker-compose -f docker-compose.yml down
  docker-compose -f docker-compose.yml rm -f
  docker-compose -f docker-compose.yml build
  docker stop $(docker ps -a -q) > /dev/null 2>&1 &&
  docker rm $(docker ps -a -q) > /dev/null 2>&1
  TIMESTAMP2=$(date)
  echo "This build ended on $TIMESTAMP2."
fi

if [ "$1" == "Part-One-Postman-Newman-Workshop-Examples" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  source ./.env
  echo
  echo "------------------------------------[[[[ Test Tool Docker Container - Part One - Postman Newman Example ]]]]------------------------------------"
  echo
  echo "This Docker Container will run various tools combined with Robot Framework. This run started on $TIMESTAMP."
  echo
  docker-compose -f docker-compose.yml down
  docker-compose -f docker-compose.yml rm -f
  docker-compose -f docker-compose.yml build
  docker-compose run docker-test-runner commands-running-inside-a-docker-container.sh Postman-Newman-Part-One-Serial-Run
  docker stop $(docker ps -a -q) &&
  docker rm $(docker ps -a -q)
  TIMESTAMP2=$(date)
  echo "This test run ended on $TIMESTAMP2."
fi

if [ "$1" == "Part-One-cURL-Workshop-Examples" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  source ./.env
  echo
  echo "------------------------------------[[[[ Test Tool Docker Container - Part One - cURL Examples ]]]]------------------------------------"
  echo
  echo "This Docker Container will run various tools combined with Robot Framework. This run started on $TIMESTAMP."
  echo
  ## The following file removal command for '.pabotsuitenames' prevents this error when running several different PaBot Docker examples...
  ## [ ERROR ] Suite 'Robot Framework test run with Requests Library in parallel' contains no tests in suite
  rm -rf ./Workshop-Examples/.pabotsuitenames
  rm -rf ./Workshop-Examples/Workshop-Part-Three/pabot_results
  docker-compose -f docker-compose.yml down
  docker-compose -f docker-compose.yml rm -f
  docker-compose -f docker-compose.yml build
  docker-compose run docker-test-runner commands-running-inside-a-docker-container.sh cURL-Part-One-Serial-And-Parallel-Run
  docker stop $(docker ps -a -q) &&
  docker rm $(docker ps -a -q)
  TIMESTAMP2=$(date)
  echo "This test run ended on $TIMESTAMP2."
fi

if [ "$1" == "Part-One-Requests-Library-Workshop-Examples" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  source ./.env
  echo
  echo "------------------------------------[[[[ Test Tool Docker Container - Part One - Requests Library Examples ]]]]------------------------------------"
  echo
  echo "This Docker Container will run various tools combined with Robot Framework. This run started on $TIMESTAMP."
  echo
  ## The following file removal command for '.pabotsuitenames' prevents this error when running several different PaBot Docker examples...
  ## [ ERROR ] Suite 'Robot Framework test run with Requests Library in parallel' contains no tests in suite
  rm -rf ./Workshop-Examples/.pabotsuitenames
  rm -rf ./Workshop-Examples/Workshop-Part-Three/pabot_results
  docker-compose -f docker-compose.yml down
  docker-compose -f docker-compose.yml rm -f
  docker-compose -f docker-compose.yml build
  docker-compose run docker-test-runner commands-running-inside-a-docker-container.sh Requests-Library-Part-One-Serial-And-Parallel-Run
  docker stop $(docker ps -a -q) &&
  docker rm $(docker ps -a -q)
  TIMESTAMP2=$(date)
  echo "This test run ended on $TIMESTAMP2."
fi

if [ "$1" == "Part-One-Python-Library-Workshop-Examples" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  source ./.env
  echo
  echo "------------------------------------[[[[ Test Tool Docker Container - Part One - Python Library Examples ]]]]------------------------------------"
  echo
  echo "This Docker Container will run various tools combined with Robot Framework. This run started on $TIMESTAMP."
  echo
  ## The following file removal command for '.pabotsuitenames' prevents this error when running several different PaBot Docker examples...
  ## [ ERROR ] Suite 'Robot Framework test run with Requests Library in parallel' contains no tests in suite
  rm -rf ./Workshop-Examples/.pabotsuitenames
  rm -rf ./Workshop-Examples/Workshop-Part-Three/pabot_results
  docker-compose -f docker-compose.yml down
  docker-compose -f docker-compose.yml rm -f
  docker-compose -f docker-compose.yml build
  docker-compose run docker-test-runner commands-running-inside-a-docker-container.sh Python-Library-Part-One-Serial-And-Parallel-Run
  docker stop $(docker ps -a -q) &&
  docker rm $(docker ps -a -q)
  TIMESTAMP2=$(date)
  echo "This test run ended on $TIMESTAMP2."
fi

if [ "$1" == "Part-One-Run-All-Docker-Workshop-Examples" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  source ./.env
  echo
  echo "------------------------------------[[[[ Test Tool Docker Container - Part One - Run All Docker Examples ]]]]------------------------------------"
  echo
  echo "This Docker Container will run various tools combined with Robot Framework. This run started on $TIMESTAMP."
  echo
  ## The following file removal command for '.pabotsuitenames' prevents this error when running several different PaBot Docker examples...
  ## [ ERROR ] Suite 'Robot Framework test run with Requests Library in parallel' contains no tests in suite
  rm -rf ./Workshop-Examples/.pabotsuitenames
  rm -rf ./Workshop-Examples/Workshop-Part-Three/pabot_results
  docker-compose -f docker-compose.yml down
  docker-compose -f docker-compose.yml rm -f
  docker-compose -f docker-compose.yml build
  docker-compose run docker-test-runner commands-running-inside-a-docker-container.sh Python-Library-Part-One-Serial-And-Parallel-Run
  docker stop $(docker ps -a -q) &&
  docker rm $(docker ps -a -q)
  TIMESTAMP2=$(date)
  echo "This test run ended on $TIMESTAMP2."
fi

if [ "$1" == "Part-Two-Postman-Newman-Workshop-Examples" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  source ./.env
  echo
  echo "------------------------------------[[[[ Test Tool Docker Container - Part Two - Postman Newman Example ]]]]------------------------------------"
  echo
  echo "This Docker Container will run various tools combined with Robot Framework. This run started on $TIMESTAMP."
  echo
  docker-compose -f docker-compose.yml down
  docker-compose -f docker-compose.yml rm -f
  docker-compose -f docker-compose.yml build
  docker-compose run docker-test-runner commands-running-inside-a-docker-container.sh Postman-Newman-Part-Two-Listeners-Randomized-Test-Execution-Failure-Notifications
  docker stop $(docker ps -a -q) &&
  docker rm $(docker ps -a -q)
  TIMESTAMP2=$(date)
  echo "This test run ended on $TIMESTAMP2."
fi

if [ "$1" == "Part-Two-Python-Library-Workshop-Examples" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  source ./.env
  echo
  echo "------------------------------------[[[[ Test Tool Docker Container - Part Two - Python Library Examples ]]]]------------------------------------"
  echo
  echo "This Docker Container will run various tools combined with Robot Framework. This run started on $TIMESTAMP."
  echo
  ## The following file removal command for '.pabotsuitenames' prevents this error when running several different PaBot Docker examples...
  ## [ ERROR ] Suite 'Robot Framework test run with Requests Library in parallel' contains no tests in suite
  rm -rf ./Workshop-Examples/.pabotsuitenames
  rm -rf ./Workshop-Examples/Workshop-Part-Three/pabot_results
  docker-compose -f docker-compose.yml down
  docker-compose -f docker-compose.yml rm -f
  docker-compose -f docker-compose.yml build
  docker-compose run docker-test-runner commands-running-inside-a-docker-container.sh Python-Library-Part-Two-Listeners-Randomized-Test-And-Suite-Execution-Failure-Notifications
  docker stop $(docker ps -a -q) &&
  docker rm $(docker ps -a -q)
  TIMESTAMP2=$(date)
  echo "This test run ended on $TIMESTAMP2."
fi

if [ "$1" == "Part-Two-Requests-Library-Workshop-Examples" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  source ./.env
  echo
  echo "------------------------------------[[[[ Test Tool Docker Container - Part Two - Requests Library Examples ]]]]------------------------------------"
  echo
  echo "This Docker Container will run various tools combined with Robot Framework. This run started on $TIMESTAMP."
  echo
  ## The following file removal command for '.pabotsuitenames' prevents this error when running several different PaBot Docker examples...
  ## [ ERROR ] Suite 'Robot Framework test run with Requests Library in parallel' contains no tests in suite
  rm -rf ./Workshop-Examples/.pabotsuitenames
  rm -rf ./Workshop-Examples/Workshop-Part-Three/pabot_results
  docker-compose -f docker-compose.yml down
  docker-compose -f docker-compose.yml rm -f
  docker-compose -f docker-compose.yml build
  docker-compose run docker-test-runner commands-running-inside-a-docker-container.sh Requests-Library-Part-Two-Random-String-Test-Data-Generation-For-API-Fuzz-Tests
  docker stop $(docker ps -a -q) &&
  docker rm $(docker ps -a -q)
  TIMESTAMP2=$(date)
  echo "This test run ended on $TIMESTAMP2."
fi

if [ "$1" == "Part-Two-cURL-Workshop-Examples" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  source ./.env
  echo
  echo "------------------------------------[[[[ Test Tool Docker Container - Part Two - cURL Examples ]]]]------------------------------------"
  echo
  echo "This Docker Container will run various tools combined with Robot Framework. This run started on $TIMESTAMP."
  echo
  ## The following file removal command for '.pabotsuitenames' prevents this error when running several different PaBot Docker examples...
  ## [ ERROR ] Suite 'Robot Framework test run with Requests Library in parallel' contains no tests in suite
  rm -rf ./Workshop-Examples/.pabotsuitenames
  rm -rf ./Workshop-Examples/Workshop-Part-Three/pabot_results
  docker-compose -f docker-compose.yml down
  docker-compose -f docker-compose.yml rm -f
  docker-compose -f docker-compose.yml build
  docker-compose run docker-test-runner commands-running-inside-a-docker-container.sh cURL-Part-Two-Random-Malformed-Test-Data-Generation-For-API-Fuzz-Tests
  docker stop $(docker ps -a -q) &&
  docker rm $(docker ps -a -q)
  TIMESTAMP2=$(date)
  echo "This test run ended on $TIMESTAMP2."
fi

if [ "$1" == "Long-Graphwalker-Run-Workshop-Example" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  source ./.env
  echo
  echo "------------------------------------[[[[ Test Tool Docker Container - Part Two - Long Graphwalker Run Example ]]]]------------------------------------"
  echo
  echo "This Docker Container will run various tools combined with Robot Framework. This run started on $TIMESTAMP."
  echo
  docker-compose -f docker-compose.yml down
  docker-compose -f docker-compose.yml rm -f
  docker-compose -f docker-compose.yml build
  docker-compose run docker-test-runner commands-running-inside-a-docker-container.sh All-Tests-Passed-Do-Long-Graphwalker-Run
  docker stop $(docker ps -a -q) &&
  docker rm $(docker ps -a -q)
  TIMESTAMP2=$(date)
  echo "This test run ended on $TIMESTAMP2."
fi

if [ "$1" == "Short-Graphwalker-Run-Workshop-Example" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  source ./.env
  echo
  echo "------------------------------------[[[[ Test Tool Docker Container - Part Two - Short Graphwalker Run Example ]]]]------------------------------------"
  echo
  echo "This Docker Container will run various tools combined with Robot Framework. This run started on $TIMESTAMP."
  echo
  docker-compose -f docker-compose.yml down
  docker-compose -f docker-compose.yml rm -f
  docker-compose -f docker-compose.yml build
  docker-compose run docker-test-runner commands-running-inside-a-docker-container.sh Some-Tests-Failed-Do-Short-Graphwalker-Run
  docker stop $(docker ps -a -q) &&
  docker rm $(docker ps -a -q)
  TIMESTAMP2=$(date)
  echo "This test run ended on $TIMESTAMP2."
fi

if [ "$1" == "Previous-Long-Graphwalker-Run-Workshop-Example" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  source ./.env
  echo
  echo "------------------------------------[[[[ Test Tool Docker Container - Part Two - Long Graphwalker Run Example - Run Previous LongGraphwalkerPath.csv ]]]]------------------------------------"
  echo
  echo "This Docker Container will run various test tools combined with Robot Framework. This run started on $TIMESTAMP."
  echo
  docker-compose -f docker-compose.yml down
  docker-compose -f docker-compose.yml rm -f
  docker-compose -f docker-compose.yml build
  docker-compose run docker-test-runner commands-running-inside-a-docker-container.sh Long-Graphwalker-Run-Detected-Errors-Do-Previous-Run
  docker stop $(docker ps -a -q) &&
  docker rm $(docker ps -a -q)
  TIMESTAMP2=$(date)
  echo "This test run ended on $TIMESTAMP2."
fi

if [ "$1" == "Previous-Short-Graphwalker-Run-Workshop-Example" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  source ./.env
  echo
  echo "------------------------------------[[[[ Test Tool Docker Container - Part Two - Short Graphwalker Run Example -  Run Previous ShortGraphwalkerPath.csv ]]]]------------------------------------"
  echo
  echo "This Docker Container will run various test tools combined with Robot Framework. This run started on $TIMESTAMP."
  echo
  docker-compose -f docker-compose.yml down
  docker-compose -f docker-compose.yml rm -f
  docker-compose -f docker-compose.yml build
  docker-compose run docker-test-runner commands-running-inside-a-docker-container.sh Short-Graphwalker-Run-Detected-Errors-Do-Previous-Run
  docker stop $(docker ps -a -q) &&
  docker rm $(docker ps -a -q)
  TIMESTAMP2=$(date)
  echo "This test run ended on $TIMESTAMP2."
fi

if [ "$1" == "Remote-Test-Process-Triggered-By-A-Webhook-Docker-Example" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  source ./.env
  echo
  echo "------------------------------------[[[[ Run A Remote Test Process - Part Two - Webhook Triggered Example ]]]]------------------------------------"
  echo
  echo "This Docker Container will run various tools combined with Robot Framework. This run started on $TIMESTAMP."
  echo
  ## The following file removal command for '.pabotsuitenames' prevents this error when running several different PaBot Docker examples...
  ## [ ERROR ] Suite 'Robot Framework test run with Requests Library in parallel' contains no tests in suite
  rm -rf ./RobotFramework/.pabotsuitenames
  rm -rf ./RobotFramework/Workshop-Part-Three/pabot_results
  docker-compose -f docker-compose.yml build > /dev/null 2>&1
  clear
  docker-compose run --publish 9080:9080 docker-test-runner-webhook
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
  echo "https://github.com/jg8481/Tool-Strategies-Lone-Testers-Test-Leadership-Congress-2019/blob/master/_.pdf"
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

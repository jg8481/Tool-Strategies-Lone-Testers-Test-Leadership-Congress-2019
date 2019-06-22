#!/bin/bash
clear

if [ "$1" == "Hybrid-Tool-Desktop-Workshop-Example" ]; then
  echo
  echo "------------------------------------[[[[ Hybrid Test Tool inspired by Session-Based Test Management -- Desktop Version ]]]]------------------------------------"
  echo
  echo "This working test example and prototype is still in progress. It tries to get close to the approach that James and Jonathon Bach mention here... http://www.satisfice.com/sbtm/"
  echo
  echo "If you have a private Slack acount, please take this chance to create a .slacktee config file in the Shared-Resources folder using the template.slacktee example."
  echo
  echo
  echo
  echo
  echo "Some of my recommendations while using this tool:"
  echo
  echo
  echo "Recommendation 1 -> (Assuming Git is your version control tool...) Consider using a bug hotspot detection approach from within the git repo(s) of the system-under-test. The following shell oneliners work well, but requires your team's git commit messages to provide enough information..."
  echo
  echo "cd /path/to/the/name-of-your-repo && git log --grep='bug' --grep='fix' --pretty=oneline --abbrev-commit | uniq"
  echo
  echo "cd /path/to/the/name-of-your-repo && git log --since=3.days --grep='bug' --grep='fix' --pretty=oneline --abbrev-commit | uniq"
  echo
  echo "Followed by this shell oneliner to get more details about a commit you want to investigate deeper..."
  echo
  echo "git log -c insert-the-commit-you-want-to-investigate-deeper"
  echo
  echo "More information about bug hotspot detection can be found in the following blog..."
  echo
  echo "http://google-engtools.blogspot.com/2011/12/bug-prediction-at-google.html"
  echo
  echo
  echo "Recommendation 2 -> Consider using a bug risk prediction tool called gitrisky..."
  echo
  echo "https://github.com/hinnefe2/gitrisky"
  echo
  echo "After installing gitrisky and running the 'gitrisky train' command in your git repo the following Shell script works well, but also requires the team's git commit messages to provide enough information..."
  echo
  echo "In another terminal window run this command from this repo and follow the instructions... bash ./gitrisky-oneline-example.sh"
  echo
  echo "The gitrisky tool will not work if the 'gitrisky train' command returns a message that says something like...  Model trained on X training examples with 0 positive cases"
  echo
  echo
  echo
  echo
  echo "Please make sure that robotmetrics is installed... https://github.com/adiralashiva8/robotframework-metrics"
  echo
  echo 'The following required fields must be filled out before testing can begin...'
  echo
  read -p "-> Please provide a Test Environment (Dev, QA, or Staging) for this test session : " TEST_ENVIRONMENT
  read -p "-> Please provide your first name : " TESTER_NAME
  read -p "-> Please provide the number of sessions. This number controls how many times this test tool runs : " NUMBER_OF_SESSIONS
  echo
  TIMESTAMP1=$(date +'Date_%m-%d-%Y_Time_%H%M-%s')
  #TIMESTAMP2=$(date +"%I:%M %p")
  TIMESTAMP2=$(date +'%m-%d-%Y %I:%M %p')
  rm -rf ./Workshop-Examples/Workshop-Part-Three/RobotFramework-Metrics-Results/*.xml
  rm -rf ./Workshop-Examples/Workshop-Part-Three/RobotFramework-Metrics-Results/*.html
  rm -rf ./Workshop-Examples/Workshop-Part-Three/most-recent-sbtm-desktop-test-session-metrics.xml &&
  rm -rf ./Workshop-Examples/Workshop-Part-Three/most-recent-sbtm-desktop-test-session-log.html &&
  rm -rf ./Workshop-Examples/Workshop-Part-Three/most-recent-sbtm-desktop-test-session-metrics.html &&
  ##--> Create more Robot Framework test files for more phases as needed. Add them to the same folder.
  for ((i = 1; i <= $NUMBER_OF_SESSIONS; i++)); do
      echo
      echo "This is Session-Based Test number $i."
      echo
      echo 'The following required fields must be filled out before testing can continue...'
      echo
      read -p "-> Please provide a GitHub Pull Request Number for this testing session: " PULL_REQUEST_NUMBER
      read -p "-> Please provide a Jira Task Number for this testing session: " JIRA_TASK_NUMBER
      echo
      robot --nostatusrc --variable TEST_ENVIRONMENT:${TEST_ENVIRONMENT} --variable TESTER_NAME:${TESTER_NAME} --variable SESSION_NUMBER:${i} --variable PULL_REQUEST_NUMBER:${PULL_REQUEST_NUMBER} --variable JIRA_TASK_NUMBER:${JIRA_TASK_NUMBER} --report NONE --log $TESTER_NAME-$TIMESTAMP1-Jira-Task-Number-$JIRA_TASK_NUMBER-GitHub-PR-Number-$PULL_REQUEST_NUMBER-Session-Number-$i-desktop_sbtm_functional_test_log.html --output $TESTER_NAME-$TIMESTAMP1-Jira-Task-Number-$JIRA_TASK_NUMBER-GitHub-PR-Number-$PULL_REQUEST_NUMBER-Session-Number-$i-desktop_sbtm_functional_test_output.xml -N "$TESTER_NAME tested Jira Task Number $JIRA_TASK_NUMBER in the $TEST_ENVIRONMENT environment -- GitHub Pull Rquest Number $PULL_REQUEST_NUMBER was deployed to that environment -- Session-Based Test number $i for $TIMESTAMP2 on Desktop -- " -d ./Workshop-Examples/Workshop-Part-Three/ ./Workshop-Examples/Tests/Workshop-Part-Two/*-Desktop.robot &&
      cp ./Workshop-Examples/Workshop-Part-Three/$TESTER_NAME-$TIMESTAMP1-Jira-Task-Number-$JIRA_TASK_NUMBER-GitHub-PR-Number-$PULL_REQUEST_NUMBER-Session-Number-$i-desktop_sbtm_functional_test_output.xml ./Workshop-Examples/Workshop-Part-Three/RobotFramework-Metrics-Results/$TESTER_NAME-$TIMESTAMP1-Jira-Task-Number-$JIRA_TASK_NUMBER-GitHub-PR-Number-$PULL_REQUEST_NUMBER-Session-Number-$i-desktop_sbtm_functional_test_output.xml &&
      cp ./Workshop-Examples/Workshop-Part-Three/$TESTER_NAME-$TIMESTAMP1-Jira-Task-Number-$JIRA_TASK_NUMBER-GitHub-PR-Number-$PULL_REQUEST_NUMBER-Session-Number-$i-desktop_sbtm_functional_test_log.html ./Workshop-Examples/Workshop-Part-Three/RobotFramework-Metrics-Results/$TESTER_NAME-$TIMESTAMP1-Jira-Task-Number-$JIRA_TASK_NUMBER-GitHub-PR-Number-$PULL_REQUEST_NUMBER-Session-Number-$i-desktop_sbtm_functional_test_log.html &&
      robotmetrics --email false --inputpath ./Workshop-Examples/Workshop-Part-Three/RobotFramework-Metrics-Results --output "$TESTER_NAME-$TIMESTAMP1-Jira-Task-Number-$JIRA_TASK_NUMBER-GitHub-PR-Number-$PULL_REQUEST_NUMBER-Session-Number-$i-desktop_sbtm_functional_test_output.xml" --log "$TESTER_NAME-$TIMESTAMP1-Jira-Task-Number-$JIRA_TASK_NUMBER-GitHub-PR-Number-$PULL_REQUEST_NUMBER-Session-Number-$i-desktop_sbtm_functional_test_log.html" --logo "https://upload.wikimedia.org/wikipedia/commons/e/e4/Robot-framework-logo.png" &&
      cp ./Workshop-Examples/Workshop-Part-Three/$TESTER_NAME-$TIMESTAMP1-Jira-Task-Number-$JIRA_TASK_NUMBER-GitHub-PR-Number-$PULL_REQUEST_NUMBER-Session-Number-$i-desktop_sbtm_functional_test_output.xml ./Workshop-Examples/Workshop-Part-Three/most-recent-sbtm-desktop-test-session-metrics.xml &&
      cp ./Workshop-Examples/Workshop-Part-Three/$TESTER_NAME-$TIMESTAMP1-Jira-Task-Number-$JIRA_TASK_NUMBER-GitHub-PR-Number-$PULL_REQUEST_NUMBER-Session-Number-$i-desktop_sbtm_functional_test_log.html ./Workshop-Examples/Workshop-Part-Three/most-recent-sbtm-desktop-test-session-log.html &&
      rm -rf ./Workshop-Examples/Workshop-Part-Three/metrics-2*.html &&
      robotmetrics --email false --inputpath ./Workshop-Examples/Workshop-Part-Three --output "most-recent-sbtm-desktop-test-session-metrics.xml" --log "most-recent-sbtm-desktop-test-session-log.html" --logo "https://upload.wikimedia.org/wikipedia/commons/e/e4/Robot-framework-logo.png" &&
      cp -fR ./Workshop-Examples/Workshop-Part-Three/metrics-2*.html ./Workshop-Examples/Workshop-Part-Three/most-recent-sbtm-desktop-test-session-metrics.html &&
      sleep 5s
  done
  cp ./Workshop-Examples/Workshop-Part-Three/most-recent-sbtm-desktop-test-session-log.html ./Workshop-Examples/Workshop-Part-Three/RobotFramework-Metrics-Results/most-recent-sbtm-desktop-test-session-log.html &&
  cp ./Workshop-Examples/Workshop-Part-Three/most-recent-sbtm-desktop-test-session-metrics.html ./Workshop-Examples/Workshop-Part-Three/RobotFramework-Metrics-Results/most-recent-sbtm-desktop-test-session-metrics.html &&
  rm -rf ./Workshop-Examples/Workshop-Part-Three/metrics-2*.html &&
  rm -rf ./Workshop-Examples/Workshop-Part-Three/RobotFramework-Metrics-Results/*_test_log.html &&
  rm -rf ./Workshop-Examples/Workshop-Part-Three/RobotFramework-Metrics-Results/*_test_output.xml
fi


if [ "$1" == "Hybrid-Tool-Desktop-Charles-Proxy-Workshop-Example" ]; then
  echo
  echo "------------------------------------[[[[ Hybrid Test Tool inspired by Session-Based Test Management -- Desktop Version with Charles Proxy ]]]]------------------------------------"
  echo
  echo "This working test example and prototype is still in progress. It tries to get close to the approach that James and Jonathon Bach mention here... http://www.satisfice.com/sbtm/"
  echo
  echo "If you have a private Slack acount, please take this chance to create a .slacktee config file in the Shared-Resources folder using the template.slacktee example."
  echo
  echo
  echo
  echo
  echo "Some of my recommendations while using this tool:"
  echo
  echo
  echo "Recommendation 1 -> (Assuming Git is your version control tool...) Consider using a bug hotspot detection approach from within the git repo(s) of the system-under-test. The following shell oneliners work well, but requires your team's git commit messages to provide enough information..."
  echo
  echo "cd /path/to/the/name-of-your-repo && git log --grep='bug' --grep='fix' --pretty=oneline --abbrev-commit | uniq"
  echo
  echo "cd /path/to/the/name-of-your-repo && git log --since=3.days --grep='bug' --grep='fix' --pretty=oneline --abbrev-commit | uniq"
  echo
  echo "Followed by this shell oneliner to get more details about a commit you want to investigate deeper..."
  echo
  echo "git log -c insert-the-commit-you-want-to-investigate-deeper"
  echo
  echo "More information about bug hotspot detection can be found in the following blog..."
  echo
  echo "http://google-engtools.blogspot.com/2011/12/bug-prediction-at-google.html"
  echo
  echo
  echo "Recommendation 2 -> Consider using a bug risk prediction tool called gitrisky..."
  echo
  echo "https://github.com/hinnefe2/gitrisky"
  echo
  echo "After installing gitrisky and running the 'gitrisky train' command in your git repo the following Shell script works well, but also requires the team's git commit messages to provide enough information..."
  echo
  echo "In another terminal window run this command from this repo and follow the instructions... bash ./gitrisky-oneline-example.sh"
  echo
  echo "The gitrisky tool will not work if the 'gitrisky train' command returns a message that says something like...  Model trained on X training examples with 0 positive cases"
  echo
  echo
  echo
  echo
  echo "Please make sure that robotmetrics is installed... https://github.com/adiralashiva8/robotframework-metrics"
  echo
  echo 'The following required fields must be filled out before testing can begin...'
  echo
  read -p "-> Please provide a Test Environment (Dev, QA, or Staging) for this test session : " TEST_ENVIRONMENT
  read -p "-> Please provide your first name : " TESTER_NAME
  read -p "-> Please provide the number of sessions. This number controls how many times this test tool runs : " NUMBER_OF_SESSIONS
  echo
  TIMESTAMP1=$(date +'Date_%m-%d-%Y_Time_%H%M-%s')
  #TIMESTAMP2=$(date +"%I:%M %p")
  TIMESTAMP2=$(date +'%m-%d-%Y %I:%M %p')
  rm -rf ./Workshop-Examples/Workshop-Part-Three/RobotFramework-Metrics-Results/*.xml
  rm -rf ./Workshop-Examples/Workshop-Part-Three/RobotFramework-Metrics-Results/*.html
  rm -rf ./Workshop-Examples/Workshop-Part-Three/most-recent-sbtm-desktop-test-session-metrics.xml &&
  rm -rf ./Workshop-Examples/Workshop-Part-Three/most-recent-sbtm-desktop-test-session-log.html &&
  rm -rf ./Workshop-Examples/Workshop-Part-Three/most-recent-sbtm-desktop-test-session-metrics.html &&
  ##--> Create more Robot Framework test files for more phases as needed. Add them to the same folder.
  for ((i = 1; i <= $NUMBER_OF_SESSIONS; i++)); do
      echo
      echo "This is Session-Based Test number $i."
      echo
      echo 'The following required fields must be filled out before testing can continue...'
      echo
      read -p "-> Please provide a GitHub Pull Request Number for this testing session: " PULL_REQUEST_NUMBER
      read -p "-> Please provide a Jira Task Number for this testing session: " JIRA_TASK_NUMBER
      echo
      robot --nostatusrc --variable TEST_ENVIRONMENT:${TEST_ENVIRONMENT} --variable TESTER_NAME:${TESTER_NAME} --variable SESSION_NUMBER:${i} --variable PULL_REQUEST_NUMBER:${PULL_REQUEST_NUMBER} --variable JIRA_TASK_NUMBER:${JIRA_TASK_NUMBER} --report NONE --log $TESTER_NAME-$TIMESTAMP1-Jira-Task-Number-$JIRA_TASK_NUMBER-GitHub-PR-Number-$PULL_REQUEST_NUMBER-Session-Number-$i-desktop_sbtm_functional_test_log.html --output $TESTER_NAME-$TIMESTAMP1-Jira-Task-Number-$JIRA_TASK_NUMBER-GitHub-PR-Number-$PULL_REQUEST_NUMBER-Session-Number-$i-desktop_sbtm_functional_test_output.xml -N "$TESTER_NAME tested Jira Task Number $JIRA_TASK_NUMBER in the $TEST_ENVIRONMENT environment -- GitHub Pull Rquest Number $PULL_REQUEST_NUMBER was deployed to that environment -- Session-Based Test number $i for $TIMESTAMP2 on Desktop -- " -d ./Workshop-Examples/Workshop-Part-Three/ ./Workshop-Examples/Tests/Workshop-Part-Two/*-Charles-Proxy.robot &&
      cp ./Workshop-Examples/Workshop-Part-Three/$TESTER_NAME-$TIMESTAMP1-Jira-Task-Number-$JIRA_TASK_NUMBER-GitHub-PR-Number-$PULL_REQUEST_NUMBER-Session-Number-$i-desktop_sbtm_functional_test_output.xml ./Workshop-Examples/Workshop-Part-Three/RobotFramework-Metrics-Results/$TESTER_NAME-$TIMESTAMP1-Jira-Task-Number-$JIRA_TASK_NUMBER-GitHub-PR-Number-$PULL_REQUEST_NUMBER-Session-Number-$i-desktop_sbtm_functional_test_output.xml &&
      cp ./Workshop-Examples/Workshop-Part-Three/$TESTER_NAME-$TIMESTAMP1-Jira-Task-Number-$JIRA_TASK_NUMBER-GitHub-PR-Number-$PULL_REQUEST_NUMBER-Session-Number-$i-desktop_sbtm_functional_test_log.html ./Workshop-Examples/Workshop-Part-Three/RobotFramework-Metrics-Results/$TESTER_NAME-$TIMESTAMP1-Jira-Task-Number-$JIRA_TASK_NUMBER-GitHub-PR-Number-$PULL_REQUEST_NUMBER-Session-Number-$i-desktop_sbtm_functional_test_log.html &&
      robotmetrics --email false --inputpath ./Workshop-Examples/Workshop-Part-Three/RobotFramework-Metrics-Results --output "$TESTER_NAME-$TIMESTAMP1-Jira-Task-Number-$JIRA_TASK_NUMBER-GitHub-PR-Number-$PULL_REQUEST_NUMBER-Session-Number-$i-desktop_sbtm_functional_test_output.xml" --log "$TESTER_NAME-$TIMESTAMP1-Jira-Task-Number-$JIRA_TASK_NUMBER-GitHub-PR-Number-$PULL_REQUEST_NUMBER-Session-Number-$i-desktop_sbtm_functional_test_log.html" --logo "https://upload.wikimedia.org/wikipedia/commons/e/e4/Robot-framework-logo.png" &&
      cp ./Workshop-Examples/Workshop-Part-Three/$TESTER_NAME-$TIMESTAMP1-Jira-Task-Number-$JIRA_TASK_NUMBER-GitHub-PR-Number-$PULL_REQUEST_NUMBER-Session-Number-$i-desktop_sbtm_functional_test_output.xml ./Workshop-Examples/Workshop-Part-Three/most-recent-sbtm-desktop-test-session-metrics.xml &&
      cp ./Workshop-Examples/Workshop-Part-Three/$TESTER_NAME-$TIMESTAMP1-Jira-Task-Number-$JIRA_TASK_NUMBER-GitHub-PR-Number-$PULL_REQUEST_NUMBER-Session-Number-$i-desktop_sbtm_functional_test_log.html ./Workshop-Examples/Workshop-Part-Three/most-recent-sbtm-desktop-test-session-log.html &&
      rm -rf ./Workshop-Examples/Workshop-Part-Three/metrics-2*.html &&
      robotmetrics --email false --inputpath ./Workshop-Examples/Workshop-Part-Three --output "most-recent-sbtm-desktop-test-session-metrics.xml" --log "most-recent-sbtm-desktop-test-session-log.html" --logo "https://upload.wikimedia.org/wikipedia/commons/e/e4/Robot-framework-logo.png" &&
      cp -fR ./Workshop-Examples/Workshop-Part-Three/metrics-2*.html ./Workshop-Examples/Workshop-Part-Three/most-recent-sbtm-desktop-test-session-metrics.html &&
      sleep 5s
  done
  cp ./Workshop-Examples/Workshop-Part-Three/most-recent-sbtm-desktop-test-session-log.html ./Workshop-Examples/Workshop-Part-Three/RobotFramework-Metrics-Results/most-recent-sbtm-desktop-test-session-log.html &&
  cp ./Workshop-Examples/Workshop-Part-Three/most-recent-sbtm-desktop-test-session-metrics.html ./Workshop-Examples/Workshop-Part-Three/RobotFramework-Metrics-Results/most-recent-sbtm-desktop-test-session-metrics.html &&
  rm -rf ./Workshop-Examples/Workshop-Part-Three/metrics-2*.html &&
  rm -rf ./Workshop-Examples/Workshop-Part-Three/RobotFramework-Metrics-Results/*_test_log.html &&
  rm -rf ./Workshop-Examples/Workshop-Part-Three/RobotFramework-Metrics-Results/*_test_output.xml
fi

usage_explanation() {
  echo
  echo
  echo "------------------------------------[[[[ Tool Runner Script ]]]]------------------------------------"
  echo
  echo
  echo "Please read the following to get a full explanation about how this works."
  echo
  echo "https://github.com/jg8481/Robot-Framework-Lone-Tester-Strategies-RoboCon-2019/blob/master/README.md"
  echo
  echo "https://github.com/jg8481/Robot-Framework-Lone-Tester-Strategies-RoboCon-2019/blob/master/Robot_Framework_strategies_for_the_lone_tester_RoboCon-2019-Workshop-Slides.pdf"
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

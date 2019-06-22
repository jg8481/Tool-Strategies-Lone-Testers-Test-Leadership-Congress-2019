#! /bin/bash

clear
TIMESTAMP=$(date)

if [ "$1" == "Combined-Results-Dashboard-Workshop-Example" ]; then
  # The git CLI tool is required before proceeding or you can do all of this manually through GitHub's app.
  # You should consider setting up your own deployment strategy for your Robot Framework results files.
  rm -rf ./combined-results.html
  echo
  echo "------------------------------------[[[[ Gather, Combine Results, And Deploy To Heroku -- Combined Results Dashboard ]]]]------------------------------------"
  echo
  rebot --removekeywords name:Capture\ Page\ Screenshot --removekeywords name:Take\ Screenshot --suitestatlevel 1 -N "Combined Results Dashboard - " --report NONE --log ./combined-results.html ./Workshop-Examples/Workshop-Part-Three/*output.xml
  echo "Gathered, combined results files, and deployed them to Heroku on $TIMESTAMP" > ./git_commit_message.txt
  GIT_COMMIT_MESSAGE=$(cat ./git_commit_message.txt) &&
  git add . &&
  git commit -m "$GIT_COMMIT_MESSAGE" &&
  git push origin master
fi

if [ "$1" == "Metrics-Dashboard-Workshop-Example" ]; then
  # The git CLI tool is required before proceeding or you can do all of this manually through GitHub's app.
  # The https://github.com/jg8481/Robot-Framework-Lone-Tester-Metrics-RoboCon-2019 repo was used to deploy new dashboards to https://robocon2019-sbtm-dashboard.herokuapp.com/
  # You should consider setting up your own deployment strategy for your Robot Framework results files.
  rm -rf ./Workshop-Examples/Workshop-Part-Three/RobotFramework-Metrics-Results/Robot-Framework-Lone-Tester-Metrics-RoboCon-2019
  echo
  echo "------------------------------------[[[[ Gather, Combine Metrics, And Deploy To Heroku -- Robot Framework Metrics Dashboard ]]]]------------------------------------"
  echo
  cd ./Workshop-Examples/Workshop-Part-Three/
  ## find . -name \*.jpg -exec cp {} ./RobotFramework-Metrics-Results \; > /dev/null 2>&1 &&
  cd ./RobotFramework-Metrics-Results
  git clone https://github.com/jg8481/Robot-Framework-Lone-Tester-Metrics-RoboCon-2019.git ./Robot-Framework-Lone-Tester-Metrics-RoboCon-2019
  rm -rf ./Robot-Framework-Lone-Tester-Metrics-RoboCon-2019/*.jpg &&
  rm -rf ./Robot-Framework-Lone-Tester-Metrics-RoboCon-2019/*.html &&
  ## cp ./most-recent-sbtm-desktop-test-session-log.html ./Robot-Framework-Lone-Tester-Metrics-RoboCon-2019/most-recent-sbtm-desktop-test-session-log.html &&
  cp ./most-recent-sbtm-desktop-test-session-metrics.html ./Robot-Framework-Lone-Tester-Metrics-RoboCon-2019/most-recent-sbtm-desktop-test-session-metrics.html &&
  ## find . -name \*.jpg -exec cp {} ./Robot-Framework-Lone-Tester-Metrics-RoboCon-2019 \; > /dev/null 2>&1 &&
  echo "Gathered, metrics files, and deployed them to Heroku on $TIMESTAMP" > ./git_commit_message.txt &&
  GIT_COMMIT_MESSAGE=$(cat ./git_commit_message.txt) &&
  cd ./Robot-Framework-Lone-Tester-Metrics-RoboCon-2019
  git add . &&
  git commit -m "$GIT_COMMIT_MESSAGE" &&
  git push origin master &&
  cd ..
  rm -rf ./Robot-Framework-Lone-Tester-Metrics-RoboCon-2019
fi

if [ "$1" == "Delete-All-Results-Files" ]; then
  # Only do this if you are absolutely sure...
  echo
  echo "------------------------------------[[[[ Delete All Results Files ]]]]------------------------------------"
  echo
  echo
  rm -rf ./Workshop-Examples/Workshop-Part-Three/*.xml
  rm -rf ./Workshop-Examples/Workshop-Part-Three/*.html
  rm -rf ./Workshop-Examples/Workshop-Part-Three/*.png
  rm -rf ./Workshop-Examples/Workshop-Part-Three/*.jpg
  rm -rf ./Workshop-Examples/Workshop-Part-Three/RobotFramework-Metrics-Results/*.html
  rm -rf ./Workshop-Examples/Workshop-Part-Three/Graphwalker-Model-Based-Test-Results/*.html
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

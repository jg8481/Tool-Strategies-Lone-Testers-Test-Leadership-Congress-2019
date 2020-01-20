#!/bin/bash


if [ "$1" == "Postman-Newman-Part-One-Serial-Run" ]; then
  echo
  echo
  echo 'TEST_ENVIRONMENT='$TEST_ENVIRONMENT
  echo 'URL1='$URL1
  echo 'URL2='$URL2
  echo 'URL3='$URL3
  echo 'BASE_URL='$BASE_URL
  echo
  echo
  cd /rfw
  echo
  echo
  echo "The following will run the Docker-Example-Postman-Newman.robot file."
  echo
  echo
  time robot --report NONE --output postman-newman-part-one-serial-output.xml --log postman-newman-part-one-serial-run.html -N "Robot Framework test run with a Postman Newman Collection running one Postman Folder at a time in serial" -d ./Workshop-Part-Three ./Tests/Workshop-Part-One/Docker-Example-Postman-Newman.robot &&
  echo '^ Measuring the robot run with the "time" command.'
  echo
  echo
fi

if [ "$1" == "cURL-Part-One-Serial-And-Parallel-Run" ]; then
  echo
  echo
  echo 'TEST_ENVIRONMENT='$TEST_ENVIRONMENT
  echo 'URL1='$URL1
  echo 'URL2='$URL2
  echo 'URL3='$URL3
  echo 'BASE_URL='$BASE_URL
  echo
  echo
  cd /rfw
  echo
  echo
  echo "The following will run Docker-Example-Curl1.robot and Docker-Example-Curl2.robot files in serial."
  echo
  echo
  time robot --variable BASE_URL:${BASE_URL} --report NONE --output curl-part-one-serial-output.xml --log curl-part-one-serial-run.html -N "Robot Framework test run with cURL in serial" -d ./Workshop-Part-Three ./Tests/Workshop-Part-One/Docker-Example-Curl*.robot &&
  echo '^ Measuring the robot run with the "time" command.'
  echo
  echo
  echo
  echo "The following will run Docker-Example-Curl1.robot and Docker-Example-Curl2.robot files in parallel."
  echo
  echo
  time pabot --verbose --variable BASE_URL:${BASE_URL} --report NONE --output curl-part-one-parallel-output.xml --log curl-part-one-parallel-run.html -N "Robot Framework test run with cURL in parallel" -d ./Workshop-Part-Three ./Tests/Workshop-Part-One/Docker-Example-Curl*.robot &&
  echo '^ Measuring the pabot run with the "time" command.'
  echo
  echo
  rm -rf ./.pabotsuitenames
fi

if [ "$1" == "Requests-Library-Part-One-Serial-And-Parallel-Run" ]; then
  echo
  echo
  echo 'TEST_ENVIRONMENT='$TEST_ENVIRONMENT
  echo 'URL1='$URL1
  echo 'URL2='$URL2
  echo 'URL3='$URL3
  echo 'BASE_URL='$BASE_URL
  echo
  echo
  cd /rfw
  echo
  echo
  echo "The following will run Docker-Example-Requests-Library1.robot and Docker-Example-Requests-Library2.robot files in serial."
  echo
  echo
  time robot --variable BASE_URL:${BASE_URL} --report NONE --output requests-library-part-one-serial-output.xml --log requests-library-part-one-serial-run.html -N "Robot Framework test run with Requests Library in serial" -d ./Workshop-Part-Three ./Tests/Workshop-Part-One/Docker-Example-Requests-Library*.robot &&
  echo '^ Measuring the robot run with the "time" command.'
  echo
  echo
  echo
  echo "The following will run Docker-Example-Requests-Library1.robot and Docker-Example-Requests-Library2.robot files in parallel."
  echo
  echo
  time pabot --verbose --variable BASE_URL:${BASE_URL} --report NONE --output requests-library-part-one-parallel-output.xml --log requests-library-part-one-parallel-run.html -N "Robot Framework test run with Requests Library in parallel" -d ./Workshop-Part-Three ./Tests/Workshop-Part-One/Docker-Example-Requests-Library*.robot &&
  echo '^ Measuring the pabot run with the "time" command.'
  echo
  echo
  rm -rf ./.pabotsuitenames
fi

if [ "$1" == "Python-Library-Part-One-Serial-And-Parallel-Run" ]; then
  echo
  echo
  echo 'TEST_ENVIRONMENT='$TEST_ENVIRONMENT
  echo 'URL1='$URL1
  echo 'URL2='$URL2
  echo 'URL3='$URL3
  echo 'BASE_URL='$BASE_URL
  echo
  echo
  cd /rfw
  echo
  echo
  echo "The following will run Docker-Example-Python-Library1.robot and Docker-Example-Python-Library2.robot files in serial."
  echo
  echo
  time robot --variable URL1:${URL1} --variable URL1:${URL2} --variable URL1:${URL3} --report NONE --output python-library-part-one-serial-output.xml --log python-library-part-one-serial-run.html -N "Robot Framework test run with user-created Python Library in serial" -d ./Workshop-Part-Three ./Tests/Workshop-Part-One/Docker-Example-Python-Library*.robot &&
  echo '^ Measuring the robot run with the "time" command.'
  echo
  echo
  echo
  echo "The following will run Docker-Example-Python-Library1.robot and Docker-Example-Python-Library2.robot files in parallel."
  echo
  echo
  time pabot --verbose --report NONE --output python-library-part-one-parallel-output.xml --log python-library-part-one-parallel-run.html -N "Robot Framework test run with user-created Python Library in parallel" -d ./Workshop-Part-Three ./Tests/Workshop-Part-One/Docker-Example-Python-Library*.robot &&
  echo '^ Measuring the pabot run with the "time" command.'
  echo
  echo
  rm -rf ./.pabotsuitenames
fi

if [ "$1" == "Part-One-Serial-And-Parallel-Run-All-Robot-Files" ]; then
  echo
  echo
  echo 'TEST_ENVIRONMENT='$TEST_ENVIRONMENT
  echo 'URL1='$URL1
  echo 'URL2='$URL2
  echo 'URL3='$URL3
  echo 'BASE_URL='$BASE_URL
  echo
  echo
  cd /rfw
  echo
  echo
  echo "The following will run all of the Docker examples for Part One in serial."
  echo
  echo
  time robot --dryrun --report NONE --output part-one-all-examples-serial-output.xml --log part-one-all-examples-serial-run.html -N "Robot Framework test run all of the Docker examples for Part One in serial" -d ./Workshop-Part-Three ./Tests/Workshop-Part-One/*.robot &&
  echo '^ Measuring the robot run with the "time" command.'
  echo
  echo
  echo
  echo "The following will run all of the Docker examples for Part One in parallel."
  echo
  echo
  time pabot --dryrun --report NONE --output python-library-part-one-parallel-output.xml --log python-library-part-one-parallel-run.html -N "Robot Framework test run all of the Docker examples for Part One in parallel" -d ./Workshop-Part-Three ./Tests/Workshop-Part-One/*.robot &&
  echo '^ Measuring the pabot run with the "time" command.'
  echo
  echo
  rm -rf ./.pabotsuitenames
fi

if [ "$1" == "Postman-Newman-Part-Two-Listeners-Randomized-Test-Execution-Failure-Notifications" ]; then
  echo
  echo
  echo 'TEST_ENVIRONMENT='$TEST_ENVIRONMENT
  echo 'URL1='$URL1
  echo 'URL2='$URL2
  echo 'URL3='$URL3
  echo 'BASE_URL='$BASE_URL
  echo
  echo
  cd /rfw
  envsubst < ./Shared-Resources/template.slacktee > ./Shared-Resources/.slacktee
  echo
  echo
  echo "The following will run the Docker-Example-Postman-Newman-Enhanced-Version.robot file that now utilizes 2 types of Robot Framework listeners and a team notification keyword. This test is also triggered in random order using the '--randomize tests' option. A test will fail, then a Slack notification will be sent out through the SharedKeywordsAndListeners.robot resource file."
  echo
  echo
  robot --variable TEST_ENVIRONMENT:${TEST_ENVIRONMENT} --randomize tests --report NONE --output postman-newman-part-two-serial-output.xml --log postman-newman-part-two-serial-run.html -N "Robot Framework test run with a Postman Newman Collection running one Postman Folder at a time in serial random order" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/Docker-Example-Postman-Newman-Enhanced-Version.robot &&
  echo
  echo
  echo "At this point the Robot Framework test rerun will be triggered. It will fail again (as intended) and another Slack notification will be sent out through the SharedKeywordsAndListeners.robot resource file."
  echo
  echo
  robot --nostatusrc --variable TEST_ENVIRONMENT:${TEST_ENVIRONMENT} --rerunfailedsuites /rfw/Workshop-Part-Three/postman-newman-part-two-serial-output.xml --report NONE --output rerun-postman-newman-part-two-serial-output.xml --log postman-newman-part-two-serial-run.html -N "Robot Framework test run with a Postman Newman Collection running one Postman Folder at a time in serial random order" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/Docker-Example-Postman-Newman-Enhanced-Version.robot &&
  echo
  echo
  echo "At this point the outputs will be merged with a ReBot command."
  echo
  echo
  rebot --nostatusrc --report NONE --log /rfw/Workshop-Part-Three/postman-newman-part-two-serial-run.html --output /rfw/Workshop-Part-Three/postman-newman-part-two-serial-output.xml --merge /rfw/Workshop-Part-Three/postman-newman-part-two-serial-output.xml /rfw/Workshop-Part-Three/rerun-postman-newman-part-two-serial-output.xml
fi

if [ "$1" == "Python-Library-Part-Two-Listeners-Randomized-Test-And-Suite-Execution-Failure-Notifications" ]; then
  echo
  echo
  echo 'TEST_ENVIRONMENT='$TEST_ENVIRONMENT
  echo 'URL1='$URL1
  echo 'URL2='$URL2
  echo 'URL3='$URL3
  echo 'BASE_URL='$BASE_URL
  echo
  echo
  cd /rfw
  envsubst < ./Shared-Resources/template.slacktee > ./Shared-Resources/.slacktee
  echo
  echo
  echo "The following will do a parallel run of the Docker-Example-Python-Library1-Enhanced-Version.robot and Docker-Example-Python-Library2-Enhanced-Version.robot files, and utilize 2 types of Robot Framework listeners and a team notification keyword. This test is also triggered in random order using the '--randomize all' option. Tests will fail, then Slack notifications will be sent out through the SharedKeywordsAndListeners.robot resource file."
  echo
  echo
  pabot --verbose --variable TEST_ENVIRONMENT:${TEST_ENVIRONMENT} --randomize all --report NONE --output python-library-part-two-parallel-output.xml --log python-library-part-two-parallel-run.html -N "Robot Framework test run with user-created Python Library in parallel" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/Docker-Example-Python-Library*.robot &&
  echo
  ## FYI: The following blocks were expected to rerun the parallel randomized tests that failed, but I received the error below instead.
  ##
  ## ********************************************************************************
  ## ********************************************************************************
  ## The following used the '--rerunfailed' option...
  ##
  #pabot --verbose --variable TEST_ENVIRONMENT:${TEST_ENVIRONMENT} --randomize all --report NONE --output python-library-part-two-parallel-output.xml --log python-library-part-two-parallel-run.html -N "Robot Framework test run with user-created Python Library in parallel" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/Docker-Example-Python-Library*.robot &&
  #pabot --nostatusrc --variable TEST_ENVIRONMENT:${TEST_ENVIRONMENT} --rerunfailed /rfw/Workshop-Part-Three/python-library-part-two-parallel-output.xml --report NONE --output rerun-python-library-part-two-parallel-output.xml --log python-library-part-two-parallel-run.html -N "Robot Framework test run with user-created Python Library in parallel random order" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/Docker-Example-Python-Library*.robot &&
  #rebot --report NONE --log /rfw/Workshop-Part-Three/python-library-part-two-parallel-run.html --output /rfw/Workshop-Part-Three/python-library-part-two-parallel-output.xml --merge /rfw/Workshop-Part-Three/python-library-part-two-parallel-output.xml /rfw/Workshop-Part-Three/rerun-python-library-part-two-parallel-output.xml &&
  ## ********************************************************************************
  ## ********************************************************************************
  ## The following used the '--rerunfailedsuites' option...
  ##
  #pabot --verbose --variable TEST_ENVIRONMENT:${TEST_ENVIRONMENT} --randomize all --report NONE --output python-library-part-two-parallel-output.xml --log python-library-part-two-parallel-run.html -N "Robot Framework test run with user-created Python Library in parallel" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/Docker-Example-Python-Library1-Enhanced-Version.robot ./Tests/Workshop-Part-Two/Docker-Example-Python-Library2-Enhanced-Version.robot &&
  #pabot --nostatusrc --variable TEST_ENVIRONMENT:${TEST_ENVIRONMENT} --rerunfailedsuites /rfw/Workshop-Part-Three/python-library-part-two-parallel-output.xml --report NONE --output rerun-python-library-part-two-parallel-output.xml --log python-library-part-two-parallel-run.html -N "Robot Framework test run with user-created Python Library in parallel random order" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/Docker-Example-Python-Library*.robot &&
  #rebot --report NONE --log /rfw/Workshop-Part-Three/python-library-part-two-parallel-run.html --output /rfw/Workshop-Part-Three/python-library-part-two-parallel-output.xml --merge /rfw/Workshop-Part-Three/python-library-part-two-parallel-output.xml /rfw/Workshop-Part-Three/rerun-python-library-part-two-parallel-output.xml &&
  ## ********************************************************************************
  ## ********************************************************************************
  ## Both the '--rerunfailed' and '--rerunfailedsuites' options resulted in the same error...
  ##
  ## get_suite_names: output_file='./Workshop-Part-Three/pabot_results/suite_names.xml' does not exist
  ## [STDERR] from suite search:
  ## [ ERROR ] Error in file '/rfw/Tests/Workshop-Part-Two/Docker-Example-Python-Library1-Enhanced-Version.robot': Non-existing setting ''
  ## ********************************************************************************
  ## ********************************************************************************
  echo
  echo "The following will do a serial run of the Docker-Example-Python-Library1-Enhanced-Version.robot and Docker-Example-Python-Library2-Enhanced-Version.robot files, and utilize 2 types of Robot Framework listeners and a team notification keyword. This test is also triggered in random order using the '--randomize all' option. Tests will fail, then Slack notifications will be sent out through the SharedKeywordsAndListeners.robot resource file."
  echo
  echo
  robot --variable TEST_ENVIRONMENT:${TEST_ENVIRONMENT} --randomize all --report NONE --output python-library-part-two-serial-output.xml --log python-library-part-two-serial-run.html -N "Robot Framework test run with user-created Python Library one test at a time in serial random order" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/Docker-Example-Python-Library*.robot &&
  echo
  echo
  echo "At this point the Robot Framework test reruns will be triggered. They will fail again (as intended) and more Slack notifications will be sent out through the SharedKeywordsAndListeners.robot resource file."
  echo
  echo
  robot --nostatusrc --variable TEST_ENVIRONMENT:${TEST_ENVIRONMENT} --rerunfailedsuites /rfw/Workshop-Part-Three/python-library-part-two-serial-output.xml --report NONE --output rerun-python-library-part-two-serial-output.xml --log python-library-part-two-serial-run.html -N "Robot Framework test run with user-created Python Library one test at a time in serial random order" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/Docker-Example-Python-Library*.robot &&
  echo
  echo
  echo "At this point only the serial outputs will be merged with a ReBot command."
  echo
  echo
  rebot --report NONE --log /rfw/Workshop-Part-Three/python-library-part-two-serial-run.html --output /rfw/Workshop-Part-Three/python-library-part-two-serial-output.xml --merge /rfw/Workshop-Part-Three/python-library-part-two-serial-output.xml /rfw/Workshop-Part-Three/rerun-python-library-part-two-serial-output.xml
  rm -rf ./.pabotsuitenames
fi

if [ "$1" == "Requests-Library-Part-Two-Random-String-Test-Data-Generation-For-API-Fuzz-Tests" ]; then
  echo
  echo
  echo 'TEST_ENVIRONMENT='$TEST_ENVIRONMENT
  echo 'URL1='$URL1
  echo 'URL2='$URL2
  echo 'URL3='$URL3
  echo 'BASE_URL='$BASE_URL
  echo
  echo
  cd /rfw
  envsubst < ./Shared-Resources/template.slacktee > ./Shared-Resources/.slacktee
  echo
  echo
  echo "The following will run Docker-Example-Requests-Library1-Enhanced-Version.robot and Docker-Example-Requests-Library2-Enhanced-Version.robot files in serial and generate random string test data using Robot Framwork's String library."
  echo
  echo
  robot --variable BASE_URL:${BASE_URL} --report NONE --output requests-library-part-two-serial-output.xml --log requests-library-part-two-serial-run.html -N "Robot Framework test run with Requests Library in serial and generate random string test data using Robot Framwork's String library" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/Docker-Example-Requests-Library*.robot &&
  echo
  echo
  echo
  echo "The following will run Docker-Example-Requests-Library1-Enhanced-Version.robot and Docker-Example-Requests-Library2-Enhanced-Version.robot files in parallel and generate random string test data using Robot Framwork's String library."
  echo
  echo
  pabot --verbose --variable BASE_URL:${BASE_URL} --report NONE --output requests-library-part-two-parallel-output.xml --log requests-library-part-two-parallel-run.html -N "Robot Framework test run with Requests Library in parallel and generate random string test data using Robot Framwork's String library" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/Docker-Example-Requests-Library*.robot &&
  echo
  echo
  rm -rf ./.pabotsuitenames
fi

if [ "$1" == "cURL-Part-Two-Random-Malformed-Test-Data-Generation-For-API-Fuzz-Tests" ]; then
  echo
  echo
  echo 'TEST_ENVIRONMENT='$TEST_ENVIRONMENT
  echo 'URL1='$URL1
  echo 'URL2='$URL2
  echo 'URL3='$URL3
  echo 'BASE_URL='$BASE_URL
  echo
  echo
  cd /rfw
  envsubst < ./Shared-Resources/template.slacktee > ./Shared-Resources/.slacktee
  echo
  echo
  echo "The following will run Docker-Example-Curl1-Enhanced-Version.robot and Docker-Example-Curl2-Enhanced-Version.robot files in serial and generate random malformed test data using the Radamsa general-purpose fuzzer."
  echo
  echo
  robot --variable BASE_URL:${BASE_URL} --report NONE --output curl-part-two-serial-output.xml --log curl-part-two-serial-run.html -N "Robot Framework test run with cURL in serial and generate random malformed test data using the Radamsa general-purpose fuzzer" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/Docker-Example-Curl*.robot &&
  echo
  echo
  RADAMSA_MALFORMED_TEST_DATA1=$(cat /rfw/Shared-Resources/malformed-test-data.txt)
  echo "This is the malformed test data used in the serial run for the Docker-Example-Curl1-Enhanced-Version.robot and Docker-Example-Curl2-Enhanced-Version.robot files..."
  echo $RADAMSA_MALFORMED_TEST_DATA1
  echo
  echo
  echo "The following will run Docker-Example-Curl1-Enhanced-Version.robot and Docker-Example-Curl2-Enhanced-Version.robot files in parallel and generate random malformed test data using the Radamsa general-purpose fuzzer."
  echo
  echo
  pabot --verbose --variable BASE_URL:${BASE_URL} --report NONE --output curl-part-two-parallel-output.xml --log curl-part-two-parallel-run.html -N "Robot Framework test run with cURL in parallel and generate random malformed test data using the Radamsa general-purpose fuzzer" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/Docker-Example-Curl*.robot &&
  echo
  echo
  RADAMSA_MALFORMED_TEST_DATA2=$(cat /rfw/Shared-Resources/malformed-test-data.txt)
  echo "This is the malformed test data used in the parallel run for the Docker-Example-Curl1-Enhanced-Version.robot and Docker-Example-Curl2-Enhanced-Version.robot files..."
  echo $RADAMSA_MALFORMED_TEST_DATA2
  echo
  echo
  rm -rf /rfw/Shared-Resources/malformed-test-data.txt
  rm -rf ./.pabotsuitenames
fi

if [ "$1" == "All-Tests-Passed-Do-Long-Graphwalker-Run" ]; then
  echo
  echo
  echo "If all of my other tests are passing I want my model-based tests to help me dig deeper for problems. To do that I want to run more Edge keywords and add keywords from GraphwalkerModel2_NegativePath.graphml to simulate bad connections."
  echo
  echo
  echo "Starting a proxy for simulating slow, spotty, HTTP connections... https://github.com/bcoe/crapify"
  rm -rf /rfw/Shared-Resources/nohup.log
  #nohup crapify start --port=5000 --speed=10000 --drop-frequency 50 --concurrency=2 > /rfw/Shared-Resources/nohup.log 2>&1 &
  nohup crapify start --port=5000 --speed=20000 --concurrency=2 > /rfw/Shared-Resources/nohup.log 2>&1 &
  echo
  echo
  echo 'TEST_ENVIRONMENT='$TEST_ENVIRONMENT
  echo 'URL1='$URL1
  echo 'URL2='$URL2
  echo 'URL3='$URL3
  echo 'BASE_URL='$BASE_URL
  echo
  echo
  cd /rfw
  rm -rf ./Workshop-Part-Three/Graphwalker-Model-Based-Test-Results/long-graphwalker-run.html
  rm -rf ./Workshop-Part-Three/long-graphwalker-run-*.xml
  rm -rf ./Workshop-Part-Three/long-graphwalker-run-ouput-*.html
  rm -rf ./Workshop-Part-Three/long-graphwalker-run-*.html
  envsubst < ./Shared-Resources/template.slacktee > ./Shared-Resources/.slacktee
  echo
  echo
  echo "A Graphwalker path is being generated with GraphwalkerModel1_PositivePath.graphml and GraphwalkerModel2_NegativePath.graphml to simulate bad connections. The Graphwalker path is stored in the LongGraphwalkerPath.csv file."
  echo
  echo
  echo "start" > ./Tests/Workshop-Part-Two/LongGraphwalkerPath.csv
  java -jar /usr/bin/graphwalker-cli-4.1.0.jar offline --start-element send_patch_to_jsonplaceholder_with_valid_data --model ./Tests/Workshop-Part-Two/GraphwalkerModel1_PositivePath.graphml "random(edge_coverage(100))" | jq -r '.currentElementName' >> ./Tests/Workshop-Part-Two/LongGraphwalkerPath.csv
  java -jar /usr/bin/graphwalker-cli-4.1.0.jar offline --start-element send_patch_to_jsonplaceholder_with_valid_data --model ./Tests/Workshop-Part-Two/GraphwalkerModel1_PositivePath.graphml "random(edge_coverage(100))" | jq -r '.currentElementName' >> ./Tests/Workshop-Part-Two/LongGraphwalkerPath.csv
  java -jar /usr/bin/graphwalker-cli-4.1.0.jar offline --start-element send_patch_to_jsonplaceholder_with_valid_data_on_a_slow_connection --model ./Tests/Workshop-Part-Two/GraphwalkerModel2_NegativePath.graphml "random(edge_coverage(100))" | jq -r '.currentElementName' >> ./Tests/Workshop-Part-Two/LongGraphwalkerPath.csv
  java -jar /usr/bin/graphwalker-cli-4.1.0.jar offline --start-element send_patch_to_jsonplaceholder_with_valid_data_on_a_slow_connection --model ./Tests/Workshop-Part-Two/GraphwalkerModel2_NegativePath.graphml "random(edge_coverage(100))" | jq -r '.currentElementName' >> ./Tests/Workshop-Part-Two/LongGraphwalkerPath.csv
  echo
  echo
  echo "The following will use LongGraphwalkerPath.csv to run the test sequence that was generated by the graphwalker-cli-4.1.0.jar file."
  echo
  echo
  while IFS=, read -r GRAPHWALKER
  do
    robot --variable GRAPHWALKER:${GRAPHWALKER} --variable BASE_URL:${BASE_URL} --variable TEST_ENVIRONMENT:${TEST_ENVIRONMENT} --include "${GRAPHWALKER}" --report NONE --output long-graphwalker-run-ouput.xml --log long-graphwalker-run.html --timestampoutputs -N "${GRAPHWALKER}" -d ./Workshop-Part-Three/ ./Tests/Workshop-Part-Two/Docker-Example-Robot-Framework-Graphwalker.robot &&
    sleep 0.5s
  done < ./Tests/Workshop-Part-Two/LongGraphwalkerPath.csv
  ## The following output merge did not generate the .xml or .html files I was expecting...
  ## rebot --suitestatlevel 1 -N "Robot Framework test run with Graphwalker model generated test sequence from the LongGraphwalkerPath.csv file" --report NONE --log /rfw/Workshop-Part-Three/merged-long-graphwalker-run.html --output /rfw/Workshop-Part-Three/merged-long-graphwalker-run-ouput.xml --merge /rfw/Workshop-Part-Three/long-graphwalker-run-ouput*.xml
  ## This one works better for standalone Robot Framework Graphwalker dashboards, but can't merge it with all of the other examples in the combined-results.html file...
  rebot --suitestatlevel 1 -N "Robot Framework test run with Graphwalker model generated test sequence from the LongGraphwalkerPath.csv file" --report NONE --log /rfw/Workshop-Part-Three/Graphwalker-Model-Based-Test-Results/long-graphwalker-run.html --output /rfw/Workshop-Part-Three/long-graphwalker-run-ouput*.xml
  rm -rf ./Workshop-Part-Three/long-graphwalker-run-*.xml
  rm -rf ./Workshop-Part-Three/long-graphwalker-run-ouput-*.html
  rm -rf ./Workshop-Part-Three/long-graphwalker-run-*.html
  echo
  echo
  echo "The following shows the captured output of the proxy simulating a slow connection..."
  echo
  echo
  cat /rfw/Shared-Resources/nohup.log
fi

if [ "$1" == "Some-Tests-Failed-Do-Short-Graphwalker-Run" ]; then
  echo
  echo
  echo "If some of my other tests are failing I still want my model-based tests to help me dig for problems, but I don't want to run it too long. To do that I want to run more Vertex keywords and focus on just the GraphwalkerModel1_PositivePath.graphml paths."
  echo
  echo
  echo 'TEST_ENVIRONMENT='$TEST_ENVIRONMENT
  echo 'URL1='$URL1
  echo 'URL2='$URL2
  echo 'URL3='$URL3
  echo 'BASE_URL='$BASE_URL
  echo
  echo
  cd /rfw
  rm -rf ./Workshop-Part-Three/Graphwalker-Model-Based-Test-Results/short-graphwalker-run.html
  rm -rf ./Workshop-Part-Three/short-graphwalker-run-*.xml
  rm -rf ./Workshop-Part-Three/short-graphwalker-run-ouput-*.html
  rm -rf ./Workshop-Part-Three/short-graphwalker-run-*.html
  envsubst < ./Shared-Resources/template.slacktee > ./Shared-Resources/.slacktee
  echo
  echo
  echo "A Graphwalker path is being generated with just the GraphwalkerModel1_PositivePath.graphml and stored in the ShortGraphwalkerPath.csv file."
  echo
  echo
  echo "start" > ./Tests/Workshop-Part-Two/ShortGraphwalkerPath.csv
  java -jar /usr/bin/graphwalker-cli-4.1.0.jar offline --start-element send_patch_to_jsonplaceholder_with_valid_data --model ./Tests/Workshop-Part-Two/GraphwalkerModel1_PositivePath.graphml "random(vertex_coverage(100))" | jq -r '.currentElementName' >> ./Tests/Workshop-Part-Two/ShortGraphwalkerPath.csv
  java -jar /usr/bin/graphwalker-cli-4.1.0.jar offline --start-element send_patch_to_jsonplaceholder_with_valid_data --model ./Tests/Workshop-Part-Two/GraphwalkerModel1_PositivePath.graphml "random(edge_coverage(100))" | jq -r '.currentElementName' >> ./Tests/Workshop-Part-Two/ShortGraphwalkerPath.csv
  java -jar /usr/bin/graphwalker-cli-4.1.0.jar offline --start-element send_patch_to_jsonplaceholder_with_valid_data --model ./Tests/Workshop-Part-Two/GraphwalkerModel1_PositivePath.graphml "random(vertex_coverage(100))" | jq -r '.currentElementName' >> ./Tests/Workshop-Part-Two/ShortGraphwalkerPath.csv
  echo
  echo
  echo "The following will use ShortGraphwalkerPath.csv to run the test sequence that was generated by the graphwalker-cli-4.1.0.jar file."
  echo
  echo
  while IFS=, read -r GRAPHWALKER
  do
    robot --variable GRAPHWALKER:${GRAPHWALKER} --variable BASE_URL:${BASE_URL} --variable TEST_ENVIRONMENT:${TEST_ENVIRONMENT} --include "${GRAPHWALKER}" --report NONE --output short-graphwalker-run-ouput.xml --log short-graphwalker-run.html --timestampoutputs -N "${GRAPHWALKER}" -d ./Workshop-Part-Three/ ./Tests/Workshop-Part-Two/Docker-Example-Robot-Framework-Graphwalker.robot &&
    sleep 0.5s
  done < ./Tests/Workshop-Part-Two/ShortGraphwalkerPath.csv
  ## The following output merge did not generate the .xml or .html files I was expecting...
  ## rebot --report NONE --log /rfw/Workshop-Part-Three/short-graphwalker-run.html --output /rfw/Workshop-Part-Three/merged-short-graphwalker-run-ouput.xml --merge /rfw/Workshop-Part-Three/short-graphwalker-run-ouput*.xml
  ## This one works better for standalone Robot Framework Graphwalker dashboards, but can't merge it with all of the other examples in the combined-results.html file...
  rebot --suitestatlevel 1 -N "Robot Framework test run with Graphwalker model generated test sequence from the ShortGraphwalkerPath.csv file" --report NONE --log /rfw/Workshop-Part-Three/Graphwalker-Model-Based-Test-Results/short-graphwalker-run.html --output /rfw/Workshop-Part-Three/short-graphwalker-run-ouput*.xml
  rm -rf ./Workshop-Part-Three/short-graphwalker-run-*.xml
  rm -rf ./Workshop-Part-Three/short-graphwalker-run-ouput-*.html
  rm -rf ./Workshop-Part-Three/short-graphwalker-run-*.html
fi

if [ "$1" == "Long-Graphwalker-Run-Detected-Errors-Do-Previous-Run" ]; then
  echo
  echo
  echo "Starting a proxy for simulating slow, spotty, HTTP connections... https://github.com/bcoe/crapify"
  rm -rf /rfw/Shared-Resources/nohup.log
  #nohup crapify start --port=5000 --speed=10000 --drop-frequency 50 --concurrency=2 > /rfw/Shared-Resources/nohup.log 2>&1 &
  nohup crapify start --port=5000 --speed=20000 --concurrency=2 > /rfw/Shared-Resources/nohup.log 2>&1 &
  echo
  echo
  echo 'TEST_ENVIRONMENT='$TEST_ENVIRONMENT
  echo 'URL1='$URL1
  echo 'URL2='$URL2
  echo 'URL3='$URL3
  echo 'BASE_URL='$BASE_URL
  echo
  echo
  cd /rfw
  rm -rf ./Workshop-Part-Three/Graphwalker-Model-Based-Test-Results/long-graphwalker-reuse-previous-path-file.html
  rm -rf ./Workshop-Part-Three/long-graphwalker-reuse-previous-path-file-*.xml
  rm -rf ./Workshop-Part-Three/long-graphwalker-reuse-previous-path-file-ouput-*.html
  rm -rf ./Workshop-Part-Three/long-graphwalker-reuse-previous-path-file-*.html
  envsubst < ./Shared-Resources/template.slacktee > ./Shared-Resources/.slacktee
  echo
  echo
  echo "The following will use the previous LongGraphwalkerPath.csv to run the test sequence that was generated by the graphwalker-cli-4.1.0.jar file."
  echo
  echo
  while IFS=, read -r GRAPHWALKER
  do
    robot --variable GRAPHWALKER:${GRAPHWALKER} --variable BASE_URL:${BASE_URL} --variable TEST_ENVIRONMENT:${TEST_ENVIRONMENT} --include "${GRAPHWALKER}" --report NONE --output long-graphwalker-reuse-previous-path-file-ouput.xml --log long-graphwalker-reuse-previous-path-file.html --timestampoutputs -N "${GRAPHWALKER}" -d ./Workshop-Part-Three/ ./Tests/Workshop-Part-Two/Docker-Example-Robot-Framework-Graphwalker.robot &&
    sleep 0.5s
  done < ./Tests/Workshop-Part-Two/LongGraphwalkerPath.csv
  ## The following output merge did not generate the .xml or .html files I was expecting...
  ## rebot --report NONE --log /rfw/Workshop-Part-Three/long-graphwalker-run.html --output /rfw/Workshop-Part-Three/merged-long-graphwalker-reuse-previous-path-file-ouput.xml --merge /rfw/Workshop-Part-Three/long-graphwalker-reuse-previous-path-file-ouput*.xml
  ## This one works better for standalone Robot Framework Graphwalker dashboards, but can't merge it with all of the other examples in the combined-results.html file...
  rebot --suitestatlevel 1 -N "Robot Framework test run with Graphwalker model generated test sequence using the previous LongGraphwalkerPath.csv file" --report NONE --log /rfw/Workshop-Part-Three/Graphwalker-Model-Based-Test-Results/long-graphwalker-reuse-previous-path-file.html --output /rfw/Workshop-Part-Three/long-graphwalker-reuse-previous-path-file-ouput*.xml
  rm -rf ./Workshop-Part-Three/long-graphwalker-reuse-previous-path-file-*.xml
  rm -rf ./Workshop-Part-Three/long-graphwalker-reuse-previous-path-file-ouput-*.html
  rm -rf ./Workshop-Part-Three/long-graphwalker-reuse-previous-path-file-*.html
  echo
  echo
  echo "The following shows the captured output of the proxy simulating a slow connection..."
  echo
  echo
  cat /rfw/Shared-Resources/nohup.log
fi

if [ "$1" == "Short-Graphwalker-Run-Detected-Errors-Do-Previous-Run" ]; then
  echo
  echo
  echo 'TEST_ENVIRONMENT='$TEST_ENVIRONMENT
  echo 'URL1='$URL1
  echo 'URL2='$URL2
  echo 'URL3='$URL3
  echo 'BASE_URL='$BASE_URL
  echo
  echo
  cd /rfw
  rm -rf ./Workshop-Part-Three/Graphwalker-Model-Based-Test-Results/short-graphwalker-reuse-previous-path-file.html
  rm -rf ./Workshop-Part-Three/short-graphwalker-reuse-previous-path-file-*.xml
  rm -rf ./Workshop-Part-Three/short-graphwalker-reuse-previous-path-file-ouput-*.html
  rm -rf ./Workshop-Part-Three/short-graphwalker-reuse-previous-path-file-*.html
  envsubst < ./Shared-Resources/template.slacktee > ./Shared-Resources/.slacktee
  echo
  echo
  echo "The following will use the previous ShortGraphwalkerPath.csv to run the test sequence that was generated by the graphwalker-cli-4.1.0.jar file."
  echo
  echo
  while IFS=, read -r GRAPHWALKER
  do
    robot --variable GRAPHWALKER:${GRAPHWALKER} --variable BASE_URL:${BASE_URL} --variable TEST_ENVIRONMENT:${TEST_ENVIRONMENT} --include "${GRAPHWALKER}" --report NONE --output short-graphwalker-reuse-previous-path-file-ouput.xml --log short-graphwalker-reuse-previous-path-file.html --timestampoutputs -N "${GRAPHWALKER}" -d ./Workshop-Part-Three/ ./Tests/Workshop-Part-Two/Docker-Example-Robot-Framework-Graphwalker.robot &&
    sleep 0.5s
  done < ./Tests/Workshop-Part-Two/ShortGraphwalkerPath.csv
  ## The following output merge did not generate the .xml or .html files I was expecting...
  ## rebot --report NONE --log /rfw/Workshop-Part-Three/short-graphwalker-reuse-previous-path-file.html --output /rfw/Workshop-Part-Three/merged-short-graphwalker-reuse-previous-path-file-ouput.xml --merge /rfw/Workshop-Part-Three/short-graphwalker-reuse-previous-path-file-ouput*.xml
  ## This one works better for standalone Robot Framework Graphwalker dashboards, but can't merge it with all of the other examples in the combined-results.html file...
  rebot --suitestatlevel 1 -N "Robot Framework test run with Graphwalker model generated test sequence using the previous ShortGraphwalkerPath.csv file" --report NONE --log /rfw/Workshop-Part-Three/Graphwalker-Model-Based-Test-Results/short-graphwalker-reuse-previous-path-file.html --output /rfw/Workshop-Part-Three/short-graphwalker-reuse-previous-path-file-ouput*.xml
  rm -rf ./Workshop-Part-Three/short-graphwalker-reuse-previous-path-file-*.xml
  rm -rf ./Workshop-Part-Three/short-graphwalker-reuse-previous-path-file-ouput-*.html
  rm -rf ./Workshop-Part-Three/short-graphwalker-reuse-previous-path-file-*.html
fi

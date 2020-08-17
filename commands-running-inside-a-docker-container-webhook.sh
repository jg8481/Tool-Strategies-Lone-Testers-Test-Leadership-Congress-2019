#!/bin/bash


echo
echo
echo "This test run was triggered by a webhook running in a Docker container."
echo
echo
echo 'TEST_ENVIRONMENT='$TEST_ENVIRONMENT
echo 'URL1='$URL1
echo 'URL2='$URL2
echo 'URL3='$URL3
echo 'BASE_URL='$BASE_URL
echo
cd /rfw
envsubst < ./Shared-Resources/template.slacktee > ./Shared-Resources/.slacktee
echo
echo
echo "The following will do a parallel run of the Docker-Example-Python-Library1-Enhanced-Version.robot and Docker-Example-Python-Library2-Enhanced-Version.robot files, and utilize 2 types of Robot Framework listeners and a team notification keyword. This test is also triggered in random order using the '--randomize all' option. Tests will fail, then Slack notifications will be sent out through the Shared-Keywords-And-Listeners.robot resource file."
echo
echo
pabot --verbose --variable TEST_ENVIRONMENT:${TEST_ENVIRONMENT} --randomize all --report NONE --output python-library-part-two-parallel-output-webhook-triggered.xml --log python-library-part-two-parallel-run-webhook-triggered.html -N "Robot Framework test run with user-created Python Library in parallel" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/Docker-Example-Python-Library*.robot &&
echo
## FYI: The following blocks were expected to rerun the parallel randomized tests that failed, but I received the error below instead.
##
## ********************************************************************************
## ********************************************************************************
## The following used the '--rerunfailed' option...
##
#pabot --verbose --variable TEST_ENVIRONMENT:${TEST_ENVIRONMENT} --randomize all --report NONE --output python-library-part-two-parallel-output-webhook-triggered.xml --log python-library-part-two-parallel-run-webhook-triggered.html -N "Robot Framework test run with user-created Python Library in parallel" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/Docker-Example-Python-Library*.robot &&
#pabot --nostatusrc --variable TEST_ENVIRONMENT:${TEST_ENVIRONMENT} --rerunfailed /rfw/Workshop-Part-Three/python-library-part-two-parallel-output-webhook-triggered.xml --report NONE --output rerun-python-library-part-two-parallel-output-webhook-triggered.xml --log python-library-part-two-parallel-run-webhook-triggered.html -N "Robot Framework test run with user-created Python Library in parallel random order" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/Docker-Example-Python-Library*.robot &&
#rebot --report NONE --log /rfw/Workshop-Part-Three/python-library-part-two-parallel-run-webhook-triggered.html --output /rfw/Workshop-Part-Three/python-library-part-two-parallel-output-webhook-triggered.xml --merge /rfw/Workshop-Part-Three/python-library-part-two-parallel-output-webhook-triggered.xml /rfw/Workshop-Part-Three/rerun-python-library-part-two-parallel-output-webhook-triggered.xml &&
## ********************************************************************************
## ********************************************************************************
## The following used the '--rerunfailedsuites' option...
##
#pabot --verbose --variable TEST_ENVIRONMENT:${TEST_ENVIRONMENT} --randomize all --report NONE --output python-library-part-two-parallel-output-webhook-triggered.xml --log python-library-part-two-parallel-run-webhook-triggered.html -N "Robot Framework test run with user-created Python Library in parallel" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/Docker-Example-Python-Library1-Enhanced-Version.robot ./Tests/Workshop-Part-Two/Docker-Example-Python-Library2-Enhanced-Version.robot &&
#pabot --nostatusrc --variable TEST_ENVIRONMENT:${TEST_ENVIRONMENT} --rerunfailedsuites /rfw/Workshop-Part-Three/python-library-part-two-parallel-output-webhook-triggered.xml --report NONE --output rerun-python-library-part-two-parallel-output-webhook-triggered.xml --log python-library-part-two-parallel-run-webhook-triggered.html -N "Robot Framework test run with user-created Python Library in parallel random order" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/Docker-Example-Python-Library*.robot &&
#rebot --report NONE --log /rfw/Workshop-Part-Three/python-library-part-two-parallel-run-webhook-triggered.html --output /rfw/Workshop-Part-Three/python-library-part-two-parallel-output-webhook-triggered.xml --merge /rfw/Workshop-Part-Three/python-library-part-two-parallel-output-webhook-triggered.xml /rfw/Workshop-Part-Three/rerun-python-library-part-two-parallel-output-webhook-triggered.xml &&
## ********************************************************************************
## ********************************************************************************
## Both the '--rerunfailed' and '--rerunfailedsuites' options resulted in the same error...
##
## get_suite_names: output_file='./Workshop-Part-Three/pabot_results/suite_names-webhook-triggered.xml' does not exist
## [STDERR] from suite search:
## [ ERROR ] Error in file '/rfw/Tests/Workshop-Part-Two/Docker-Example-Python-Library1-Enhanced-Version.robot': Non-existing setting ''
## ********************************************************************************
## ********************************************************************************
echo
echo "The following will do a serial run of the Docker-Example-Python-Library1-Enhanced-Version.robot and Docker-Example-Python-Library2-Enhanced-Version.robot files, and utilize 2 types of Robot Framework listeners and a team notification keyword. This test is also triggered in random order using the '--randomize all' option. Tests will fail, then Slack notifications will be sent out through the Shared-Keywords-And-Listeners.robot resource file."
echo
echo
robot --variable TEST_ENVIRONMENT:${TEST_ENVIRONMENT} --randomize all --report NONE --output python-library-part-two-serial-output-webhook-triggered.xml --log python-library-part-two-serial-run-webhook-triggered.html -N "Robot Framework test run with user-created Python Library one test at a time in serial random order" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/Docker-Example-Python-Library*.robot &&
echo
echo
echo "At this point the Robot Framework test reruns will be triggered. They will fail again (as intended) and more Slack notifications will be sent out through the Shared-Keywords-And-Listeners.robot resource file."
echo
echo
robot --nostatusrc --variable TEST_ENVIRONMENT:${TEST_ENVIRONMENT} --rerunfailedsuites /rfw/Workshop-Part-Three/python-library-part-two-serial-output-webhook-triggered.xml --report NONE --output rerun-python-library-part-two-serial-output-webhook-triggered.xml --log python-library-part-two-serial-run-webhook-triggered.html -N "Robot Framework test run with user-created Python Library one test at a time in serial random order" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/Docker-Example-Python-Library*.robot &&
echo
echo
echo "At this point only the serial outputs will be merged with a ReBot command."
echo
echo
rebot --report NONE --log /rfw/Workshop-Part-Three/python-library-part-two-serial-run-webhook-triggered.html --output /rfw/Workshop-Part-Three/python-library-part-two-serial-output-webhook-triggered.xml --merge /rfw/Workshop-Part-Three/python-library-part-two-serial-output-webhook-triggered.xml /rfw/Workshop-Part-Three/rerun-python-library-part-two-serial-output-webhook-triggered.xml
rm -rf ./.pabotsuitenames

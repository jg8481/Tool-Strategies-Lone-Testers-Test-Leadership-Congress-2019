#!/bin/bash

DEFAULT_RES="1280x800x24"
DEFAULT_DISPLAY=":"99
RES=${RES:-$DEFAULT_RES}
DISPLAY=${DISPLAY:-$DEFAULT_DISPLAY}
TIMESTAMP=$(date)
rm -rf ./Workshop-Part-Three/*.png
rm -rf ./Workshop-Part-Three/*.jpg
echo
echo
echo "The time inside this container is $TIMESTAMP."
echo
echo
cd /rfw/
echo "Starting Xvfb on display ${DISPLAY} with res ${RES}"
echo
echo
Xvfb ${DISPLAY} -ac -screen 0 ${RES} > /dev/null 2>&1 &
export DISPLAY=${DISPLAY}
echo
echo
echo 'TEST_ENVIRONMENT='$TEST_ENVIRONMENT
echo 'APP_URL='$APP_URL
echo 'URL2='$URL2
echo 'URL3='$URL3
echo 'BASE_URL='$BASE_URL
echo
echo
envsubst < ./Shared-Resources/template.slacktee > ./Shared-Resources/.slacktee
echo
echo
#echo "The following will do a parallel run of the Docker-Firefox.robot and Docker-Chrome.robot files."
echo "The following will run the Docker-Firefox.robot files."
echo
echo
#pabot --verbose --processes 2 --report NONE --log docker-web-browser-log.html --output docker-web-browser-output.xml -N "Robot Framework Web Browsers In Docker Container Test Run" -d ./Workshop-Part-Three/ ./Tests/Workshop-Part-Two/Docker-Example-Chrome* ./Tests/Workshop-Part-Two/Docker-Example-Firefox*
robot --report NONE --log docker-web-browser-log.html --output docker-web-browser-output.xml -N "Robot Framework Web Browser In Docker Container Test Run" -d ./Workshop-Part-Three/ ./Tests/Workshop-Part-Two/Docker-Example-Firefox*

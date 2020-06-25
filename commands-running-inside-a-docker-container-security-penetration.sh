#!/bin/bash

if [ "$1" == "Run-Kali-Linux-Tests" ]; then
  TIMESTAMP=$(date)
  rm -rf /rfw/Workshop-Part-Three/kali-linux*
  echo
  echo
  echo
  echo
  cd /rfw/
  echo
  echo
  echo
  echo
  #robot --dryrun --report NONE --output kali-linux-security-and-penetration-test-output.xml --log kali-linux-security-and-penetration-test-output.html --name "Kali Linux Security And Penetration Tests" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/Kali-Linux-Security-And-Penetration-Tests.robot
  robot --report NONE --output kali-linux-security-and-penetration-test-output.xml --log kali-linux-security-and-penetration-test-output.html --name "Kali Linux Security And Penetration Tests" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/Kali-Linux-Security-And-Penetration-Tests.robot
fi

if [ "$1" == "Run-OWASP-Zap-Tests" ]; then
  TIMESTAMP=$(date)
  export PATH="/home/zap/.local/bin:/usr/local/bin/geckodriver:$PATH"
  rm -rf /rfw/Workshop-Part-Three/owasp-zap*
  rm -rf /rfw/Workshop-Part-Three/selenium-owasp*
  rm -rf /rfw/Workshop-Part-Three/*.png
  echo "Set up test run by making sure OWASP Zap processes and any process using port 8090 or 8080 are stopped"
  pgrep zap | xargs kill > /dev/null 2>&1 &
  pgrep 8090 | xargs kill > /dev/null 2>&1 &
  pgrep 8080 | xargs kill > /dev/null 2>&1 &
  pkill -9 zap &&
  pkill -9 java
  echo
  echo
  echo
  echo
  cd /rfw
  echo
  echo
  echo
  echo
  echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Starting both XVFB (X Virtual Frame Buffer) and OWASP Zap Proxy <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
  RFW_PATH=$(pwd)
  rm -rf $RFW_PATH/Tests/Workshop-Part-Two/Resources/owasp-zap-proxy-log.txt
  nohup /zap/zap-x.sh -daemon -port 8080 -host 0.0.0.0 -config api.addrs.addr.regex=true -config api.disablekey=true >> $RFW_PATH/Tests/Workshop-Part-Two/Resources/owasp-zap-proxy-log.txt & echo $! > $RFW_PATH/Tests/Workshop-Part-Two/Resources/owasp-zap-proxy-PID.txt
  OWASP_ZAP_PROXY_PID=$(cat $RFW_PATH/Tests/Workshop-Part-Two/Resources/owasp-zap-proxy-PID.txt)
  echo
  echo
  echo
  echo
  echo "OWASP Zap has been started on PID $OWASP_ZAP_PROXY_PID"
  echo
  echo
  echo
  echo
  sleep 10s
  DEFAULT_RES="1280x800x24"
  DEFAULT_DISPLAY=":"99
  RES=${RES:-$DEFAULT_RES}
  DISPLAY=${DISPLAY:-$DEFAULT_DISPLAY}
  echo "Starting Xvfb on display ${DISPLAY} with res ${RES}"
  Xvfb ${DISPLAY} -ac -screen 0 ${RES} > /dev/null 2>&1 &
  export DISPLAY=${DISPLAY}
  echo
  echo
  echo
  echo
  #robot --dryrun --report NONE --output owasp-zap-security-and-penetration-test-output.xml --log owasp-zap-security-and-penetration-test-output.html --name "OWASP Security And Penetration Tests" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/OWASP-Zap-Security-And-Penetration-Tests.robot
  robot --report NONE --output owasp-zap-security-and-penetration-test-output.xml --log owasp-zap-security-and-penetration-test-output.html --name "OWASP Security And Penetration Tests" -d ./Workshop-Part-Three ./Tests/Workshop-Part-Two/OWASP-Zap-Security-And-Penetration-Tests.robot
  echo
  echo
  echo
  echo
  echo "Teardown the test run by stopping all OWASP Zap processes and any process using port 8090 or 8080"
  kill -s 9 $OWASP_ZAP_PROXY_PID
  pgrep zap | xargs kill > /dev/null 2>&1 &
  pgrep 8090 | xargs kill > /dev/null 2>&1 &
  pgrep 8080 | xargs kill > /dev/null 2>&1 &
  pkill -9 zap &&
  pkill -9 java
  rm -rf $RFW_PATH/Tests/Workshop-Part-Two/Resources/owasp-zap-proxy-PID.txt
fi
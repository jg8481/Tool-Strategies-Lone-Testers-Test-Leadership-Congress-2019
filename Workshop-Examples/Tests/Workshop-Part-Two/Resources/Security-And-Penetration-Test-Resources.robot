*** Settings ***
Documentation                 This is a resource file that will provide common shared Robot Framework resources for various security and penetration tests. All keywords using the anonymization tools "proxychains" or "tor" are experimental and should be used from inside a Kali Linux VM instead of Docker.
Library                       Collections
Library                       OperatingSystem
Library                       Process
Library                       String
Library                       SeleniumLibrary
Library                       ${EXECDIR}//Shared-Resources//TimeTrackingListener.py

*** Variables ***
${PATH}               ${EXECDIR}
${GLOBAL_RETRY_AMOUNT}    5

*** Keywords ***

### OWASP Zap Docker Container Keywords ###

Check OWASP Zap Proxy And XVFB Are Both Running
    Run Process    zap-cli status     alias=owasp_zap_status    shell=True    timeout=20s    on_timeout=continue
    ${OWASP_ZAP_PROXY_STATUS}=   	Get Process Result    owasp_zap_status    stdout=true
    Log    ${OWASP_ZAP_PROXY_STATUS}
    Should Contain    ${OWASP_ZAP_PROXY_STATUS}    ZAP is running
    Run Process    ps aux | grep Xvfb     alias=xvfb_status    shell=True    timeout=20s    on_timeout=continue
    ${XVFB_STATUS}=   	Get Process Result    xvfb_status    stdout=true
    Log    ${XVFB_STATUS}
    Should Contain    ${XVFB_STATUS}    Xvfb

Wait Until OWASP Zap Passive Scanner Completes
    Wait Until Keyword Succeeds   ${GLOBAL_RETRY_AMOUNT}x    2s    Check OWASP Zap Passive Scanner Status

Check OWASP Zap Passive Scanner Status
    Run Process    ${PATH}//Tests//Workshop-Part-Two//Resources//owasp-zap-status-checker.sh "0.0.0.0" "8080"    alias=passive_scanner_status    shell=True    timeout=20s    on_timeout=continue
    ${PASSIVE_SCANNER_STATUS}=   	Get Process Result    passive_scanner_status     stdout=true
    Log    ${PASSIVE_SCANNER_STATUS}
    Should Contain    ${PASSIVE_SCANNER_STATUS}    Passive scanner is finished running

Connect OWASP Zap Proxy With Firefox Browser
    [Arguments]    ${TARGET_URL}
    Check OWASP Zap Proxy And XVFB Are Both Running
    Run Process    zap-cli session new    shell=True    timeout=10s    on_timeout=continue
    ${profile}=   Evaluate     sys.modules['selenium.webdriver'].FirefoxProfile()    sys
    Call Method   ${profile}     set_preference     network.proxy.http   localhost
    Call Method   ${profile}     set_preference     network.proxy.http_port    8080
    Call Method   ${profile}     set_preference     network.proxy.ssl    localhost
    Call Method   ${profile}     set_preference     network.proxy.ssl_port    8080
    Call Method   ${profile}     set_preference     network.proxy.autodetect    False
    Call Method   ${profile}     set_preference     network.proxy.type    1
    Call Method   ${profile}     set_preference     profile.accept_untrusted_certs    True
    Create WebDriver   Firefox   firefox_profile=${profile}
    Go To    ${TARGET_URL}

Login In To Node Goat Vulnerable Website Wait For Passive Scan
    Capture Page Screenshot
    Wait Until Keyword Succeeds   ${GLOBAL_RETRY_AMOUNT}x    2s    Wait Until Page Contains    Employee    2s
    Capture Page Screenshot
    Input Text    //input[@name="userName"]    test
    Input Text    //input[@name="password"]    test
    Capture Page Screenshot
    Click Element    xpath=(//div[@class="row"])[2]
    Click Element    //button[@class="btn btn-danger"]
    Capture Page Screenshot
    Wait Until OWASP Zap Passive Scanner Completes

Run OWASP Zap Active Scan With Specific Settings Then Check Result
    [Arguments]    ${SCANNER_TYPE}    ${SCANNER_STRENGTH}    ${SCANNER_ALERT_LEVEL}    ${TARGET_URL}
    Run Process    zap-cli open-url "${TARGET_URL}"    shell=True    timeout=10s    on_timeout=continue
    Run Process    zap-cli scanners set-strength --strength "${SCANNER_STRENGTH}"    shell=True    timeout=10s    on_timeout=continue
    Run Process    zap-cli scanners set-threshold --threshold "${SCANNER_ALERT_LEVEL}"    shell=True    timeout=10s    on_timeout=continue
    Run Process    zap-cli -v active-scan --scanners "${SCANNER_TYPE}" "${TARGET_URL}" && zap-cli alerts    alias=owasp_zap_active_scanner 	  shell=True    timeout=2min    on_timeout=continue
    ${ACTIVE_SCANNER_RESULTS}=   	Get Process Result    owasp_zap_active_scanner    stdout=true
    Log    ${ACTIVE_SCANNER_RESULTS}
    Should Contain    ${ACTIVE_SCANNER_RESULTS}    Issues found: 0

Run OWASP Zap Recursive Active Scan With Specific Settings Then Check Result
    [Arguments]    ${SCANNER_TYPE}    ${SCANNER_STRENGTH}    ${SCANNER_ALERT_LEVEL}    ${TARGET_URL}
    Run Process    zap-cli open-url "${TARGET_URL}"    shell=True    timeout=10s    on_timeout=continue
    Run Process    zap-cli scanners set-strength --strength "${SCANNER_STRENGTH}"    shell=True    timeout=10s    on_timeout=continue
    Run Process    zap-cli scanners set-threshold --threshold "${SCANNER_ALERT_LEVEL}"    shell=True    timeout=10s    on_timeout=continue
    Run Process    zap-cli --verbose active-scan --scanners "${SCANNER_TYPE}" --recursive "${TARGET_URL}" && zap-cli alerts    alias=owasp_zap_recursive_active_scanner  	 shell=True    timeout=2min    on_timeout=continue
    ${RECURSIVE_ACTIVE_SCANNER_RESULTS}=   	Get Process Result    owasp_zap_recursive_active_scanner    stdout=true
    Log    ${RECURSIVE_ACTIVE_SCANNER_RESULTS}
    Should Contain    ${RECURSIVE_ACTIVE_SCANNER_RESULTS}    Issues found: 0

Run OWASP Zap Passive Scan With Specific Settings Then Check Result
    [Arguments]    ${SCANNER_TYPE}    ${SCANNER_ALERT_LEVEL}    ${TARGET_URL}
    Run Process    zap-cli --verbose quick-scan --scanners "${SCANNER_TYPE}" "${TARGET_URL}" --alert-level "${SCANNER_ALERT_LEVEL}"    alias=owasp_zap_passive_scanner  	 shell=True    timeout=2min    on_timeout=continue
    ${PASSIVE_SCANNER_RESULTS}=   	Get Process Result    owasp_zap_passive_scanner    stdout=true
    Log    ${PASSIVE_SCANNER_RESULTS}
    Should Contain    ${PASSIVE_SCANNER_RESULTS}    Issues found: 0

Run OWASP Zap Recursive Passive Scan With Specific Settings Then Check Result
    [Arguments]    ${SCANNER_TYPE}    ${SCANNER_ALERT_LEVEL}    ${TARGET_URL}
    Run Process    zap-cli --verbose quick-scan --scanners "${SCANNER_TYPE}" --recursive "${TARGET_URL}" --alert-level "${SCANNER_ALERT_LEVEL}"    alias=owasp_zap_recursive_passive_scanner  	 shell=True    timeout=2min    on_timeout=continue
    ${RECURSIVE_PASSIVE_SCANNER_RESULTS}=   	Get Process Result    owasp_zap_recursive_passive_scanner    stdout=true
    Log    ${RECURSIVE_PASSIVE_SCANNER_RESULTS}
    Should Contain    ${RECURSIVE_PASSIVE_SCANNER_RESULTS}   Issues found: 0

Run OWASP Zap Spider Recursive Passive Scan With Specific Settings Then Check Result
    [Arguments]    ${SCANNER_TYPE}    ${SCANNER_ALERT_LEVEL}    ${TARGET_URL}
    Run Process    zap-cli --verbose quick-scan --scanners "${SCANNER_TYPE}" --recursive --spider "${TARGET_URL}" --alert-level "${SCANNER_ALERT_LEVEL}"    alias=owasp_zap_recursive_passive_scanner  	 shell=True    timeout=2min    on_timeout=continue
    ${SPIDER_RECURSIVE_PASSIVE_SCANNER_RESULTS}=   	Get Process Result    owasp_zap_recursive_passive_scanner    stdout=true
    Log    ${SPIDER_RECURSIVE_PASSIVE_SCANNER_RESULTS}
    Should Contain    ${SPIDER_RECURSIVE_PASSIVE_SCANNER_RESULTS}   Issues found: 0

Generate OWASP Report Files
    Remove File    ${PATH}//Workshop-Part-Three//owasp-zap-report.html
    Remove File    ${PATH}//Workshop-Part-Three//owasp-zap-report.md
    Run Process    cd /rfw && zap-cli --verbose report -o ./Workshop-Part-Three/owasp-zap-report.html --output-format html    shell=True    timeout=20s    on_timeout=continue
    Run Process    cd /rfw && zap-cli --verbose report -o ./Workshop-Part-Three/owasp-zap-report.md --output-format md    shell=True    timeout=20s    on_timeout=continue

Generate Combined Selenium OWASP Report Files
    Remove File    ${PATH}//Workshop-Part-Three//selenium-owasp-zap-report.html
    Remove File    ${PATH}//Workshop-Part-Three//selenium-owasp-zap-report.md
    Run Process    cd /rfw && zap-cli --verbose report -o ./Workshop-Part-Three/selenium-owasp-zap-report.html --output-format html    shell=True    timeout=20s    on_timeout=continue
    Run Process    cd /rfw && zap-cli --verbose report -o ./Workshop-Part-Three/selenium-owasp-zap-report.md --output-format md    shell=True    timeout=20s    on_timeout=continue

Generate Reports Gather Logs And Clean Up
    Run Keyword And Ignore Error    Generate OWASP Report Files
    Run Keyword And Ignore Error    Generate Combined Selenium OWASP Report Files
    Run Keyword And Ignore Error    Gather And Display All Logs
    Run Keyword And Ignore Error    Clean Up Proxy Log And Terminate Processes

Gather And Display All Logs
    ${OWASP_ZAP_MD_REPORT}    Get File    ${PATH}//Workshop-Part-Three//owasp-zap-report.md
    Log	    ${OWASP_ZAP_MD_REPORT}
    ${SELENIUM_OWASP_ZAP_MD_REPORT}    Get File    ${PATH}//Workshop-Part-Three//selenium-owasp-zap-report.md
    Log	    ${SELENIUM_OWASP_ZAP_MD_REPORT}
    ${OWASP_ZAP_PROXY_LOG}    Get File    ${PATH}//Tests//Workshop-Part-Two//Resources//owasp-zap-proxy-log.txt
    Log	    ${OWASP_ZAP_PROXY_LOG}

Clean Up Proxy Log And Terminate Processes
    Remove File    ${PATH}//Tests//Workshop-Part-Two//Resources//owasp-zap-proxy-log.txt
    Run Keyword And Ignore Error    Terminate All Processes

### Kali Linux Docker Container Keywords ###

Generate Nmap XML Target File And Start Metasploit Database
    Run Keyword And Ignore Error    Run    apt-get update -y
    Run Keyword And Ignore Error    Run    apt-get install tor -y
    Run Keyword And Ignore Error    Run    apt-get install proxychains -y
    Run Keyword And Ignore Error    Run    systemctl stop tor
    Run Keyword And Ignore Error    Run    systemctl start tor
    Run Keyword And Ignore Error    Run    echo "socks5  127.0.0.1 9050" >> /etc/proxychains.conf
    Run Nmap Scan To Generate XML Target File    nodegoat.herokuapp.com
    Run Dig DNS Lookup Utility Tool To Get Metasploit RHOSTS Target IP    nodegoat.herokuapp.com
    Start Metasploit Database And Import Nmap XML Target File

Start Metasploit Database And Import Nmap XML Target File
    Run Process    service postgresql start &>/dev/null    shell=True    timeout=30s    on_timeout=continue
    Run Process    msfdb init &>/dev/null    shell=True    timeout=20s    on_timeout=continue
    Run Process    msfconsole -q -x "db_import /rfw/Tests/Workshop-Part-Two/Resources/metasploit-targets.xml; hosts; exit"    shell=True    timeout=30s    on_timeout=continue

Run Dig DNS Lookup Utility Tool To Get Metasploit RHOSTS Target IP
    [Arguments]    ${TARGET_URL}
    Remove File    ${PATH}//Tests//Workshop-Part-Two//Resources//metasploit-rhosts-ip.txt
    #Run    dig +short "${TARGET_URL}" | head -1 > ${PATH}//Tests//Workshop-Part-Two//Resources//metasploit-rhosts-ip.txt
    Run    proxychains dig +short "${TARGET_URL}" | head -1 > ${PATH}//Tests//Workshop-Part-Two//Resources//metasploit-rhosts-ip.txt
    Wait Until Keyword Succeeds   ${GLOBAL_RETRY_AMOUNT}x    4s    Check Metasploit RHOSTS Target IP File Contents
    Log To Console    ...
    Log To Console    ...
    Log To Console    Metasploit RHOSTS IP Target is set for tests that are not using the Metasploit Database. This is the IP...
    Log To Console    ${METASPLOIT_RHOSTS_FILE_CONTENTS_IP_ADDRESS}
    Log To Console    ...

Check Metasploit RHOSTS Target IP File Contents
    File Should Exist    ${PATH}//Tests//Workshop-Part-Two//Resources//metasploit-rhosts-ip.txt
    ${METASPLOIT_RHOSTS_FILE_CONTENTS_IP_ADDRESS}=    Get File    ${PATH}//Tests//Workshop-Part-Two//Resources//metasploit-rhosts-ip.txt
    File Should Not Be Empty    ${PATH}//Tests//Workshop-Part-Two//Resources//metasploit-rhosts-ip.txt
    Log    ${METASPLOIT_RHOSTS_FILE_CONTENTS_IP_ADDRESS}
    Set Suite Variable    ${METASPLOIT_RHOSTS_FILE_CONTENTS_IP_ADDRESS}

Run Nmap Scan To Generate XML Target File
    [Arguments]    ${TARGET_URL}
    Remove File    ${PATH}//Tests//Workshop-Part-Two//Resources//metasploit-targets.xml
    #Run    nmap -Pn -sS -A -oX /rfw/Tests/Workshop-Part-Two/Resources/metasploit-targets.xml "${TARGET_URL}"
    Run    proxychains nmap -Pn -sS -A -oX /rfw/Tests/Workshop-Part-Two/Resources/metasploit-targets.xml "${TARGET_URL}"
    Wait Until Keyword Succeeds   ${GLOBAL_RETRY_AMOUNT}x    4s    Check Metasploit XML File Contents
    Log To Console    ...
    Log To Console    ...
    Log To Console    Nmap XML File has been generated and will be used as a Target File imported into the Metasploit Database.
    Log    ${METASPLOIT_XML_FILE_CONTENTS}
    Log To Console    ...

Check Metasploit XML File Contents
    File Should Exist    ${PATH}//Tests//Workshop-Part-Two//Resources//metasploit-targets.xml
    ${METASPLOIT_XML_FILE_CONTENTS}=    Get File    ${PATH}//Tests//Workshop-Part-Two//Resources//metasploit-targets.xml
    File Should Not Be Empty    ${PATH}//Tests//Workshop-Part-Two//Resources//metasploit-targets.xml
    Should Contain    ${METASPLOIT_XML_FILE_CONTENTS}    finished
    Set Suite Variable    ${METASPLOIT_XML_FILE_CONTENTS}

Run Nmap Scan With Arguments And Check Results
    [Arguments]    ${NMAP_SCANNER_TYPE}    ${TARGET_URL}
    #Run Process    nmap "${NMAP_SCANNER_TYPE}" "${TARGET_URL}"    alias=nmap_custom_scanner 	  shell=True    timeout=4min    on_timeout=continue
    Run Process    proxychains nmap "${NMAP_SCANNER_TYPE}" "${TARGET_URL}"    alias=nmap_custom_scanner 	  shell=True    timeout=4min    on_timeout=continue
    ${NMAP_SCANNER_RESULTS}=   	Get Process Result    nmap_custom_scanner    stdout=true
    Log    ${NMAP_SCANNER_RESULTS}
    Should Contain    ${NMAP_SCANNER_RESULTS}    80/tcp  open  http
    Should Contain    ${NMAP_SCANNER_RESULTS}    443/tcp open  https

Run Nmap Vulnerability Scan With Arguments And Check Results
    [Arguments]    ${NMAP_TARGET_PORT}    ${TARGET_URL}
    #Run Process    nmap --script-updatedb 	  shell=True    timeout=2min    on_timeout=continue
    #Run Process    nmap -sV -Pn "${TARGET_URL}" --script\=vulners/vulners.nse -p"${NMAP_TARGET_PORT}"    alias=nmap_custom_vulnerability_scanner 	  shell=True    timeout=4min    on_timeout=continue
    Run Process    proxychains nmap --script-updatedb 	  shell=True    timeout=2min    on_timeout=continue
    Run Process    proxychains nmap -sV -Pn "${TARGET_URL}" --script\=vulners/vulners.nse -p"${NMAP_TARGET_PORT}"    alias=nmap_custom_vulnerability_scanner 	  shell=True    timeout=4min    on_timeout=continue
    ${NMAP_VULNERABILITY_SCANNER_RESULTS}=   	Get Process Result    nmap_custom_vulnerability_scanner    stdout=true
    Log    ${NMAP_VULNERABILITY_SCANNER_RESULTS}
    Should Not Contain    ${NMAP_VULNERABILITY_SCANNER_RESULTS}    cve
    Should Not Contain    ${NMAP_VULNERABILITY_SCANNER_RESULTS}    CVE
    Should Not Contain    ${NMAP_VULNERABILITY_SCANNER_RESULTS}    vulners

Run Metasploit Framework With Arguments And Check Results
    [Arguments]    ${METASPLOIT_FRAMEWORK_MODULE}    ${METASPLOIT_FRAMEWORK_THREADS_AMOUNT}    ${TARGET_URL}
    Run Process    msfconsole -q -x 'use ${METASPLOIT_FRAMEWORK_MODULE}; set RHOSTS ${METASPLOIT_RHOSTS_FILE_CONTENTS_IP_ADDRESS}; set THREADS ${METASPLOIT_FRAMEWORK_THREADS_AMOUNT}; run; exit'    alias=metasploit_framework 	  shell=True    timeout=4min    on_timeout=continue
    ${METASPLOIT_FRAMEWORK_RESULTS}=   	Get Process Result    metasploit_framework    stdout=true
    Log    ${METASPLOIT_FRAMEWORK_RESULTS}
    Should Contain    ${METASPLOIT_FRAMEWORK_RESULTS}    Auxiliary module execution completed
    Log To Console    ...
    Log To Console    ...
    Log To Console    All Metasploit automation results should be checked manually even if the results show PASS.
    Log To Console    ...
    Log    All Metasploit automation results should be checked manually even if the results show PASS.

Run Target XML Metasploit Framework With Arguments And Check Results
    [Arguments]    ${METASPLOIT_FRAMEWORK_MODULE}    ${METASPLOIT_FRAMEWORK_THREADS_AMOUNT}
    Run Process    msfconsole -q -x 'use ${METASPLOIT_FRAMEWORK_MODULE}; hosts -R; set THREADS ${METASPLOIT_FRAMEWORK_THREADS_AMOUNT}; run; exit'    alias=target_xml_metasploit_framework 	  shell=True    timeout=4min    on_timeout=continue
    ${TARGET_XML_METASPLOIT_FRAMEWORK_RESULTS}=   	Get Process Result    target_xml_metasploit_framework    stdout=true
    Log    ${TARGET_XML_METASPLOIT_FRAMEWORK_RESULTS}
    Should Contain    ${TARGET_XML_METASPLOIT_FRAMEWORK_RESULTS}    Auxiliary module execution completed
    Log To Console    ...
    Log To Console    ...
    Log To Console    All Metasploit automation results should be checked manually even if the results show PASS.
    Log To Console    ...
    Log    All Metasploit automation results should be checked manually even if the results show PASS.

Run Sqlmap Scan With Arguments And Check Results
    [Arguments]    ${SQLMAP_SCANNER_TYPE}    ${TARGET_URL}
    #Run Process    sqlmap --batch --tamper\="${SQLMAP_SCANNER_TYPE}" -u http://"${TARGET_URL}"    alias=sqlmap_custom_scanner 	  shell=True    timeout=4min    on_timeout=continue
    Run Process    sqlmap --batch --tamper\="${SQLMAP_SCANNER_TYPE}" -u http://"${TARGET_URL}" –tor –tor-type=SOCKS5    alias=sqlmap_custom_scanner 	  shell=True    timeout=4min    on_timeout=continue
    ${SQLMAP_SCANNER_RESULTS}=   	Get Process Result    sqlmap_custom_scanner    stdout=true
    Log    ${SQLMAP_SCANNER_RESULTS}
    Should Not Contain    ${SQLMAP_SCANNER_RESULTS}    sqlmap identified the following injection points

Clean Up Metasploit Files And Terminate Processes
    Remove File    ${PATH}//Tests//Workshop-Part-Two//Resources//metasploit-targets.xml
    Remove File    ${PATH}//Tests//Workshop-Part-Two//Resources//metasploit-rhosts-ip.txt
    Terminate All Processes

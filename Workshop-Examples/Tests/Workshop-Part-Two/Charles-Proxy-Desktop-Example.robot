*** Settings ***
Documentation    Simple example using Charles Proxy and SeleniumLibrary.
Resource         ${EXECDIR}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//Selenium-Desktop-Resources.robot
Library          ${EXECDIR}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//CharlesProxyExample.py
Library          OperatingSystem
Library          Process

Suite Teardown    Close All Browsers

*** Variables ***
${PATH}    ${EXECDIR}
${CHARLES_PROXY_SELENIUM_EXAMPLE_URL}    http://nodegoat.herokuapp.com/login
${CHARLES_PROXY_SELENIUM_BROWSER}    Firefox

*** Test Cases ***

CHARLES PROXY DESKTOP TEST : Go to the OWASP Node Goat home page in a MacOS desktop browser while Charles Proxy is recording a session and check the JSON session file.
    [Tags]    Desktop_Firefox    Charles_Proxy    Charles_Proxy_MacOS
    [Setup]    Start Charles Proxy For Desktop Browser
    Open The Firefox Browser In MacOS After Starting Charles Proxy
    Download Charles Proxy Session File And Convert It To JSON
    Check Charles Proxy JSON Session File Recording
    [Teardown]    Terminate Charles Proxy Sessions And Clean Up

*** Keywords ***

Start Charles Proxy For Desktop Browser
    Remove File    ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//new-json-session-file.chlsj
    Remove File    ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//original-raw-session-file.chls
    Remove File    ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//jq-select-output.txt
    Remove File    ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//jq-filter-output.txt
    Start Charles Proxy In Headless Mode
    Start Charles Proxy Session Recording

Download Charles Proxy Session File And Convert It To JSON
    Download Charles Proxy Session Recording
    Convert Recorded Session File

Terminate Charles Proxy Sessions And Clean Up
    Stop Charles Proxy Session Recording
    Terminate All Charles Proxy Sessions
    Remove File    ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//new-json-session-file.chlsj
    Remove File    ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//original-raw-session-file.chls
    Remove File    ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//jq-select-output.txt
    Remove File    ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//jq-filter-output.txt

Open The Firefox Browser In MacOS After Starting Charles Proxy
    Run Keyword And Ignore Error    Set Up Firefox In MacOS After Starting Charles Proxy    ${CHARLES_PROXY_SELENIUM_EXAMPLE_URL}    ${CHARLES_PROXY_SELENIUM_BROWSER}

Check Charles Proxy JSON Session File Recording
    Run JQ Select Command And Check Results    nodegoat.herokuapp.com
    Run JQ Filter Command And Check Results

Run JQ Select Command And Check Results
    [Arguments]    ${JQ_SELECT_HOST_VALUE}
    Run    cat ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//new-json-session-file.chlsj | jq '.[] | select(.host=="${JQ_SELECT_HOST_VALUE}")' > ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//jq-select-output.txt
    ${JQ_SELECT_OUTPUT}=   	Get File    ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//jq-select-output.txt
    Log    ${JQ_SELECT_OUTPUT}
    Should Contain    ${JQ_SELECT_OUTPUT}    ${JQ_SELECT_HOST_VALUE}
    Should Contain    ${JQ_SELECT_OUTPUT}    response
    Should Contain    ${JQ_SELECT_OUTPUT}    status
    Should Contain    ${JQ_SELECT_OUTPUT}    COMPLETE

Run JQ Filter Command And Check Results
    Run   cat ${PATH}/Workshop-Examples/Tests/Workshop-Part-Two/Resources/new-json-session-file.chlsj | jq .[].response.status > ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//jq-filter-output.txt
    ${JQ_FILTER_OUTPUT}=   	Get File    ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//jq-filter-output.txt
    Log    ${JQ_FILTER_OUTPUT}
    Should Contain        ${JQ_FILTER_OUTPUT}    200
    Should Not Contain    ${JQ_FILTER_OUTPUT}    401
    Should Not Contain    ${JQ_FILTER_OUTPUT}    404
    Should Not Contain    ${JQ_FILTER_OUTPUT}    500
    Should Not Contain    ${JQ_FILTER_OUTPUT}    504

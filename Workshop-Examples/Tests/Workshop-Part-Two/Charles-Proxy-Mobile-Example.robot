*** Settings ***
Documentation    Simple example using Charles Proxy and AppiumLibrary.
Resource         ${EXECDIR}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//Appium-Mobile-Resources.robot
Library          ${EXECDIR}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//CharlesProxyExample.py
Library          OperatingSystem
Library          Process

Suite Teardown    Close All Applications

*** Variables ***
${PATH}    ${EXECDIR}
${TEST_SUITE_TIMEOUT}     2
${CHARLES_PROXY_APPIUM_EXAMPLE_URL}    http://nodegoat.herokuapp.com/login

*** Test Cases ***

CHARLES PROXY MOBILE TEST - Go to the OWASP Node Goat home page in an iOS mobile browser while Charles Proxy is recording a session, and check the JSON session file.
    [Tags]    Mobile_Safari    Charles_Proxy    Charles_Proxy_IOS
    [Setup]    Start Charles Proxy For Mobile Browser
    Open The Safari Browser In IOS After Starting Charles Proxy
    Download Charles Proxy Session File And Convert It To JSON
    Check Charles Proxy JSON Session File Recording
    [Teardown]    Terminate Charles Proxy Sessions And Clean Up

*** Keywords ***

Start Charles Proxy For Mobile Browser
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

Open The Safari Browser In IOS After Starting Charles Proxy
    Set Suite Variable    ${PARALLEL_APPIUM_REMOTE_URL}    %{PARALLEL_APPIUM_REMOTE_URL1}
    Set Suite Variable    ${DEVICE_NAME_IOS}    %{DEVICE_NAME_IOS1}
    Set Suite Variable    ${PARALLEL_APPIUM_PORT}    %{PARALLEL_APPIUM_PORT1}
    Set Suite Variable    ${PARALLEL_APPIUM_WDALOCALPORT}     %{PARALLEL_APPIUM_WDALOCALPORT1}
    Should Not Be Empty     ${PARALLEL_APPIUM_REMOTE_URL}
    Should Not Be Empty     ${DEVICE_NAME_IOS}
    Should Not Be Empty     ${PARALLEL_APPIUM_PORT}
    Should Not Be Empty     ${PARALLEL_APPIUM_WDALOCALPORT}
    Run Keyword And Ignore Error    Set Up Safari In IOS After Starting Charles Proxy    ${PARALLEL_APPIUM_REMOTE_URL}    ${DEVICE_NAME_IOS}    ${PARALLEL_APPIUM_PORT}    ${PARALLEL_APPIUM_WDALOCALPORT}    ${CHARLES_PROXY_APPIUM_EXAMPLE_URL}

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


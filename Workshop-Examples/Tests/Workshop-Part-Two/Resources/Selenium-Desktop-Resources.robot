*** Settings ***

Library           ${EXECDIR}//Workshop-Examples//Shared-Resources//TimeTrackingListener.py
Library           SeleniumLibrary    run_on_failure=NOTHING
Library           Process
Library           String

*** Variables ***

${RETRY_AMOUNT}    10
${SELENIUM_IMPLICIT_WAIT}    10

*** Keywords ***

Click Sign Up Link
    Set Selenium Implicit Wait    ${SELENIUM_IMPLICIT_WAIT}
    Capture Page Screenshot
    Click Link    //a[@href="/signup"]

Check The Sign Up Page
    Set Selenium Implicit Wait    ${SELENIUM_IMPLICIT_WAIT}
    Wait Until Keyword Succeeds   ${RETRY_AMOUNT}x    0.1 sec    Wait Until Page Contains    information    0.5s
    Set Selenium Implicit Wait    ${SELENIUM_IMPLICIT_WAIT}
    Sleep    2s
    Capture Page Screenshot

Set Up Firefox Browser MacOS After Starting Charles Proxy
    [Timeout]    4 minutes
    [Arguments]    ${CHARLES_PROXY_SELENIUM_EXAMPLE_URL}    ${CHARLES_PROXY_SELENIUM_BROWSER}
    Run Process    ps aux | grep Charles     alias=charles_proxy_mac_os_status    shell=True    timeout=20s    on_timeout=continue
    ${CHARLES_PROXY_MAC_OS_STATUS}=   	Get Process Result    charles_proxy_mac_os_status    stdout=true
    Log    ${CHARLES_PROXY_MAC_OS_STATUS}
    Should Contain    ${CHARLES_PROXY_MAC_OS_STATUS}    Charles.app
    Start Process    sleep 30s && killall firefox-bin    shell=True
    Run Keyword And Ignore Error    Open Browser    ${CHARLES_PROXY_SELENIUM_EXAMPLE_URL}    ${CHARLES_PROXY_SELENIUM_BROWSER}
    Sleep    4s

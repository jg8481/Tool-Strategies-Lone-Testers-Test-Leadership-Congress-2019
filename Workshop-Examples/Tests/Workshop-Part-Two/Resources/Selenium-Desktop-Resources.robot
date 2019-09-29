*** Settings ***

Library           ${EXECDIR}//Workshop-Examples//Shared-Resources//TimeTrackingListener.py
Library           SeleniumLibrary
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

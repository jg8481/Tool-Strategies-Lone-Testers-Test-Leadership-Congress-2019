*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Resource          ${EXECDIR}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//Selenium-Desktop-Resources.robot

Suite Setup    Open Chrome Browser To Specified URL
Suite Teardown    Close Browser

*** Variables ***

${URL}      %{APP_URL}
${BROWSER}        Chrome
${RETRY_AMOUNT}    10
${SELENIUM_IMPLICIT_WAIT}    10

*** Test Cases ***

DESKTOP CHROME TEST 1 - Go to the sign up page from the login page.
    [Tags]    Desktop_Chrome
    Click Sign Up Link

DESKTOP CHROME TEST 2 - Quickly check that the sign up page loaded.
    [Tags]    Desktop_Chrome
    Check The Sign Up Page

*** Keywords ***

Open Chrome Browser To Specified URL
    Open Browser    ${URL}    ${BROWSER}
    Set Selenium Implicit Wait    ${SELENIUM_IMPLICIT_WAIT}
    Wait Until Keyword Succeeds   ${RETRY_AMOUNT}x    0.1s    Wait Until Page Contains    Password    0.5s
    Set Selenium Implicit Wait    ${SELENIUM_IMPLICIT_WAIT}
    Sleep    2s
    Capture Page Screenshot

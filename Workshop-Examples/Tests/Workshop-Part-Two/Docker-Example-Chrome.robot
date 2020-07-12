*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary

Suite Setup    Open Chrome Browser To Specified URL
Suite Teardown    Close Browser

*** Variables ***

${URL}      %{APP_URL}
${BROWSER}        Chrome
${RETRY_AMOUNT}    3
${SELENIUM_IMPLICIT_WAIT}    3

*** Test Cases ***

Go to the sign up page from the login page.
    [Tags]    Desktop_Chrome
    Click Sign Up Link

Quickly check that the sign up page loaded.
    [Tags]    Desktop_Chrome
    Check The Sign Up Page

*** Keywords ***

Browser Setup Step
    Run Keyword And Ignore Error    Close All Browsers
    ${result}=    Wait Until Keyword Succeeds   ${RETRY_AMOUNT}x    0.5s    Open Chrome Browser To Specified URL
    Capture Page Screenshot

Open Chrome Browser To Specified URL
    Open Browser    ${URL}    ${BROWSER}
    Set Selenium Implicit Wait    ${SELENIUM_IMPLICIT_WAIT}
    Wait Until Keyword Succeeds   ${RETRY_AMOUNT}x    0.1s    Wait Until Page Contains    Password    0.5s
    Set Selenium Implicit Wait    ${SELENIUM_IMPLICIT_WAIT}
    Sleep    2s
    Capture Page Screenshot

Click Sign Up Link
    Set Selenium Implicit Wait    ${SELENIUM_IMPLICIT_WAIT}
    Capture Page Screenshot
    Click Link    //a[@href="/signup"]

Check The Sign Up Page
    Set Selenium Implicit Wait    ${SELENIUM_IMPLICIT_WAIT}
    Wait Until Keyword Succeeds   ${RETRY_AMOUNT}x    0.1s    Wait Until Page Contains    information    0.5s
    Set Selenium Implicit Wait    ${SELENIUM_IMPLICIT_WAIT}
    Sleep    2s
    Capture Page Screenshot

*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Resource          ${EXECDIR}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//Selenium-Desktop-Resources.robot

Suite Setup    Open Firefox Browser To Specified URL
Suite Teardown    Close Browser

*** Variables ***

${URL}      %{APP_URL}
${BROWSER}        Firefox
${RETRY_AMOUNT}    10
${SELENIUM_IMPLICIT_WAIT}    10

*** Test Cases ***

Go to the sign up page from the login page.
    [Tags]    Desktop Firefox
    Click Sign Up Link

Quickly check that the sign up page loaded.
    [Tags]    Desktop Firefox
    Check The Sign Up Page

*** Keywords ***

Open Firefox Browser To Specified URL
    Open Browser    ${URL}    ${BROWSER}
    Set Selenium Implicit Wait    ${SELENIUM_IMPLICIT_WAIT}
    Wait Until Keyword Succeeds   ${RETRY_AMOUNT}x    0.1s    Page Should Contain    Password    0.5s
    Set Selenium Implicit Wait    ${SELENIUM_IMPLICIT_WAIT}
    Sleep    2s
    Capture Page Screenshot

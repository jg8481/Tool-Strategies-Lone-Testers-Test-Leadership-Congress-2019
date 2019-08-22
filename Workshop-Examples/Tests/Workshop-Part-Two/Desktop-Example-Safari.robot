*** Settings ***
Documentation    Simple example using SeleniumLibrary.
Resource         ${EXECDIR}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//Selenium-Desktop-Resources.robot
Library          ${EXECDIR}//Workshop-Examples//Shared-Resources//TestFailureEmailNotification.py
Library          ${EXECDIR}//Workshop-Examples//Shared-Resources//TimeTrackingListener.py
Library          OperatingSystem
Library          Process

Suite Setup    Open Safari Browser To Specified URL
Suite Teardown    Close Browser
Test Teardown     Trigger Only After Failure

*** Variables ***

${URL}      %{APP_URL}
${BROWSER}        Safari
${RETRY_AMOUNT}    10
${SELENIUM_IMPLICIT_WAIT}    10

*** Test Cases ***

Go to the sign up page from the login page.
    [Tags]    Desktop Safari
    Click Sign Up Link

Quickly check that the sign up page loaded.
    [Tags]    Desktop Safari
    Check The Sign Up Page
    #Check The Sign Up Page Demonstrate Failure

*** Keywords ***

Open Safari Browser To Specified URL
    Open Browser    ${URL}    ${BROWSER}
    Set Selenium Implicit Wait    ${SELENIUM_IMPLICIT_WAIT}
    Wait Until Keyword Succeeds   ${RETRY_AMOUNT}x    0.1s    Page Should Contain    Password    0.5s
    Set Selenium Implicit Wait    ${SELENIUM_IMPLICIT_WAIT}
    Sleep    2s
    Capture Page Screenshot

Check The Sign Up Page Demonstrate Failure
    Page Should Contain    THIS SHOULD FAIL

Trigger Only After Failure
    Run Keyword If Test Failed     Failure Detected Notify Team

Failure Detected Notify Team
    Send Short Message Through Slack And Email For Desktop Browser Check    desktop Safari checks in the Desktop-Safari.robot file    Prod

Send Short Message Through Slack And Email For Desktop Browser Check
    ## There are various solutions out there for sending Slack messages through its API. Here are some examples.
    ##
    ## robot-framework-slack-notifier is a cross-platform solution...
    ## https://github.com/Ville-/robot-framework-slack-notifier
    ##
    ## slacktee is a very simple to use Slack client that you can use to pipe text into Slack channels...
    ## https://github.com/coursehero/slacktee
    ##
    ## The folowing keyword will demonstrate slacktee...
    [Arguments]    ${TEST_NAME}    ${TEST_ENVIRONMENT}
    Run Process    echo "The ${TEST_NAME} failed in the ${TEST_ENVIRONMENT} environment." | slacktee.sh -i :nerd_face: --plain-text --config /rfw/Shared-Resources/.slacktee    shell=True    timeout=20s    on_timeout=continue
    Send Email Notification    ## You might want to include these in the email message -> ${TEST_NAME}    ${TEST_ENVIRONMENT}

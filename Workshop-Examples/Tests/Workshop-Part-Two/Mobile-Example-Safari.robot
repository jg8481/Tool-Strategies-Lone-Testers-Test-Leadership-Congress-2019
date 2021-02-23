*** Settings ***
Documentation    Simple example using AppiumLibrary.
Resource         ${EXECDIR}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//Appium-Mobile-Resources.robot
Library          ${EXECDIR}//Workshop-Examples//Shared-Resources//TestFailureEmailNotification.py
Library          ${EXECDIR}//Workshop-Examples//Shared-Resources//TimeTrackingListener.py
Library          OperatingSystem
Library          Process

Suite Setup    Open The Safari Browser In IOS
Suite Teardown    Close All Applications
Test Teardown     Trigger Only After Failure

*** Variables ***
${TEST_SUITE_TIMEOUT}     4

*** Test Cases ***

MOBILE SAFARI TEST 1 - Go to the sign up page from the login page.
    [Timeout]    ${TEST_SUITE_TIMEOUT} minutes
    [Tags]    Mobile_Safari
    Click Sign Up Link

MOBILE SAFARI TEST 2 - Quickly check that the sign up page loaded.
    [Timeout]    ${TEST_SUITE_TIMEOUT} minutes
    [Tags]    Mobile_Safari
    Check The Sign Up Page
    #Check The Sign Up Page Demonstrate Failure

*** Keywords ***

Open The Safari Browser In IOS
    [Timeout]    ${TEST_SUITE_TIMEOUT} minutes
    Set Suite Variable    ${PARALLEL_APPIUM_REMOTE_URL}    %{PARALLEL_APPIUM_REMOTE_URL1}
    Set Suite Variable    ${DEVICE_NAME_IOS}    %{DEVICE_NAME_IOS1}
    Set Suite Variable    ${PARALLEL_APPIUM_PORT}    %{PARALLEL_APPIUM_PORT1}
    Set Suite Variable    ${PARALLEL_APPIUM_WDALOCALPORT}     %{PARALLEL_APPIUM_WDALOCALPORT1}
    Should Not Be Empty     ${PARALLEL_APPIUM_REMOTE_URL}
    Should Not Be Empty     ${DEVICE_NAME_IOS}
    Should Not Be Empty     ${PARALLEL_APPIUM_PORT}
    Should Not Be Empty     ${PARALLEL_APPIUM_WDALOCALPORT}
    Set Up Safari In IOS    ${PARALLEL_APPIUM_REMOTE_URL}    ${DEVICE_NAME_IOS}    ${PARALLEL_APPIUM_PORT}    ${PARALLEL_APPIUM_WDALOCALPORT}

Check The Sign Up Page Demonstrate Failure
    Page Should Contain Text    THIS SHOULD FAIL

Trigger Only After Failure
    Run Keyword If Test Failed     Failure Detected Notify Team

Failure Detected Notify Team
    Send Short Message Through Slack And Email For Mobile Browser Check    mobile Safari checks in the Mobile-Safari.robot file    Prod

Send Short Message Through Slack And Email For Mobile Browser Check
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
    Run Process    echo "The ${TEST_NAME} failed in the ${TEST_ENVIRONMENT} environment." | slacktee.sh -i :nerd_face: --plain-text --config ${EXECDIR}/Workshop-Examples/Shared-Resources/.slacktee    shell=True    timeout=20s    on_timeout=continue
    Send Email Notification    ## You might want to include these in the email message -> ${TEST_NAME}    ${TEST_ENVIRONMENT}

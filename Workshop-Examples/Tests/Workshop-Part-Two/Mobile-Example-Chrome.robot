*** Settings ***
Documentation    Simple example using AppiumLibrary.
Resource         ${EXECDIR}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//Appium-Mobile-Resources.robot
Library          ${EXECDIR}//Workshop-Examples//Shared-Resources//TimeTrackingListener.py
Library          Screenshot

Suite Setup    Open The Chrome Browser In Android
Suite Teardown    Close All Applications

*** Variables ***
${URL}      https://nodegoat.herokuapp.com
${TEST_SUITE_TIMEOUT}     2

*** Test Cases ***

Go to the sign up page from the login page.
    [Timeout]    ${TEST_SUITE_TIMEOUT} minutes
    [Tags]    Mobile Chrome
    Run Keyword And Continue On Failure    Click Sign Up Link
    Take Screenshot Without Embedding    ${EXECDIR}//Workshop-Examples//Workshop-Part-Three//screenshot_3.jpg

Quickly check that the sign up page loaded.
    [Timeout]    ${TEST_SUITE_TIMEOUT} minutes
    [Tags]    Mobile Chrome
    Run Keyword And Continue On Failure    Check The Sign Up Page
    Take Screenshot Without Embedding    ${EXECDIR}//Workshop-Examples//Workshop-Part-Three//screenshot_2.jpg

*** Keywords ***

Open The Chrome Browser In Android
    [Timeout]    ${TEST_SUITE_TIMEOUT} minutes
    Set Suite Variable    ${PARALLEL_APPIUM_REMOTE_URL}    %{PARALLEL_APPIUM_REMOTE_URL2}
    Set Suite Variable    ${DEVICE_NAME_ANDROID}    %{DEVICE_NAME_ANDROID3}
    Set Suite Variable    ${PARALLEL_APPIUM_PORT}    %{PARALLEL_APPIUM_PORT2}
    Should Not Be Empty     ${PARALLEL_APPIUM_REMOTE_URL}
    Should Not Be Empty     ${DEVICE_NAME_ANDROID}
    Should Not Be Empty     ${PARALLEL_APPIUM_PORT}
    Set Up Chrome In Android    ${PARALLEL_APPIUM_REMOTE_URL}    ${DEVICE_NAME_ANDROID}    ${PARALLEL_APPIUM_PORT}
    Take Screenshot Without Embedding    ${EXECDIR}//Workshop-Examples//Workshop-Part-Three//screenshot_1.jpg

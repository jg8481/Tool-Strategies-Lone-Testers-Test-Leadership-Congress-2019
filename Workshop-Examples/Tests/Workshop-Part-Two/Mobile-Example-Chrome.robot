*** Settings ***
Documentation    Simple example using AppiumLibrary.
Resource         ${EXECDIR}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//Appium-Mobile-Resources.robot
Library          ${EXECDIR}//Workshop-Examples//Shared-Resources//TimeTrackingListener.py
Library          Screenshot

## The following line is commented out because of this new Chromedriver related problem...
## On July 10, 2020 started getting the following Chromedriver error after updating Android emulators.
## -> WebDriverException: Message: An unknown server-side error occurred while processing the command. Original error: chrome not reachable
#
#Suite Setup    Open The Chrome Browser In Android
Suite Teardown    Close All Applications

*** Variables ***

## The following line is commented out because of this new Chromedriver related problem...
## On July 10, 2020 started getting the following Chromedriver error after updating Android emulators.
## -> WebDriverException: Message: An unknown server-side error occurred while processing the command. Original error: chrome not reachable
#
#${TEST_SUITE_TIMEOUT}     1

*** Test Cases ***

MOBILE CHROME TEST : Go to the login page.
    [Tags]    Mobile_Chrome
    Run Keyword And Ignore Error    Open The Chrome Browser In Android

## The following lines are commented out because of this new Chromedriver related problem...
## On July 10, 2020 started getting the following Chromedriver error after updating Android emulators.
## -> WebDriverException: Message: An unknown server-side error occurred while processing the command. Original error: chrome not reachable
#
#MOBILE CHROME TEST 1 : Go to the sign up page from the login page.
#    [Timeout]    ${TEST_SUITE_TIMEOUT} minutes
#    [Tags]    Mobile_Chrome
#    Run Keyword And Continue On Failure    Click Sign Up Link
#    Take Screenshot Without Embedding    ${EXECDIR}//Workshop-Examples//Workshop-Part-Three//screenshot_3.jpg

## The following lines are commented out because of this new Chromedriver related problem...
## On July 10, 2020 started getting the following Chromedriver error after updating Android emulators.
## -> WebDriverException: Message: An unknown server-side error occurred while processing the command. Original error: chrome not reachable
#
#MOBILE CHROME TEST 2 : Quickly check that the sign up page loaded.
#    [Timeout]    ${TEST_SUITE_TIMEOUT} minutes
#    [Tags]    Mobile_Chrome
#    Run Keyword And Continue On Failure    Check The Sign Up Page
#    Take Screenshot Without Embedding    ${EXECDIR}//Workshop-Examples//Workshop-Part-Three//screenshot_2.jpg

*** Keywords ***

Open The Chrome Browser In Android
## The following line is commented out because of this new Chromedriver related problem...
## On July 10, 2020 started getting the following Chromedriver error after updating Android emulators.
## -> WebDriverException: Message: An unknown server-side error occurred while processing the command. Original error: chrome not reachable
#
#    [Timeout]    ${TEST_SUITE_TIMEOUT} minutes
    Set Suite Variable    ${PARALLEL_APPIUM_REMOTE_URL}    %{PARALLEL_APPIUM_REMOTE_URL2}
    Set Suite Variable    ${DEVICE_NAME_ANDROID}    %{DEVICE_NAME_ANDROID3}
    Set Suite Variable    ${PARALLEL_APPIUM_PORT}    %{PARALLEL_APPIUM_PORT2}
    Should Not Be Empty     ${PARALLEL_APPIUM_REMOTE_URL}
    Should Not Be Empty     ${DEVICE_NAME_ANDROID}
    Should Not Be Empty     ${PARALLEL_APPIUM_PORT}
    Set Up Chrome In Android    ${PARALLEL_APPIUM_REMOTE_URL}    ${DEVICE_NAME_ANDROID}    ${PARALLEL_APPIUM_PORT}
    Take Screenshot Without Embedding    ${EXECDIR}//Workshop-Examples//Workshop-Part-Three//screenshot_1.jpg

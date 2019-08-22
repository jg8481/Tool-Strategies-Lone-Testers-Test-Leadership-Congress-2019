*** Settings ***

Library           AppiumLibrary

*** Variables ***

${PLATFORM_VERSION_IOS}    12.2
${IOS_AUTOMATION_NAME}    XCUITest
${PLATFORM_NAME_IOS}    iOS

${PLATFORM_VERSION_ANDROID}    8
${PLATFORM_NAME_ANDROID}    Android
${ANDROID_AUTOMATION_NAME}    UiAutomator2

${RETRY_AMOUNT}    40

*** Keywords ***

Set Up Chrome In Android
    [Arguments]     ${PARALLEL_APPIUM_REMOTE_URL}    ${DEVICE_NAME_ANDROID}     ${PARALLEL_APPIUM_PORT}
    Open Application    ${PARALLEL_APPIUM_REMOTE_URL}    platformName=${PLATFORM_NAME_ANDROID}    deviceName=${DEVICE_NAME_ANDROID}    PORT=${PARALLEL_APPIUM_PORT}    automationName=${ANDROID_AUTOMATION_NAME}    browserName=Chrome    newCommandTimeout=3600
    Go To Url    %{APP_URL}
    Wait Until Keyword Succeeds   ${RETRY_AMOUNT}x    0.1 sec    Page Should Contain Text    Password    0.5s
    Sleep    1s

Set Up Safari In IOS
    [Arguments]     ${PARALLEL_APPIUM_REMOTE_URL}    ${DEVICE_NAME_IOS}    ${PARALLEL_APPIUM_PORT}    ${PARALLEL_APPIUM_WDALOCALPORT}
    Open Application    ${PARALLEL_APPIUM_REMOTE_URL}    platformName=${PLATFORM_NAME_IOS}    platformVersion=${PLATFORM_VERSION_IOS}    devicetype=simulator
    ...    deviceName=${DEVICE_NAME_IOS}    PORT=${PARALLEL_APPIUM_PORT}    WDALOCALPORT=${PARALLEL_APPIUM_WDALOCALPORT}    automationName=${IOS_AUTOMATION_NAME}     startIWDP=true
    ...    browserName=Safari     bundleid=com.apple.mobilesafari
    Go To Url    %{APP_URL}
    Wait Until Keyword Succeeds   ${RETRY_AMOUNT}x    0.1 sec    Page Should Contain Text    Password    0.5s
    Sleep    1s

Click Sign Up Link
    Sleep    2s
    Click Element    //a[@href="/signup"]

Check The Sign Up Page
    Wait Until Keyword Succeeds   ${RETRY_AMOUNT}x    0.1 sec    Page Should Contain Text    information    0.5s
    Sleep    2s

*** Settings ***

Library           AppiumLibrary    run_on_failure=No Operation

*** Variables ***

${PLATFORM_VERSION_IOS}    13.5
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
## The following line is commented out because of this new Chromedriver related problem...
## On July 10, 2020 started getting the following Chromedriver error after updating Android emulators.
## -> WebDriverException: Message: An unknown server-side error occurred while processing the command. Original error: chrome not reachable
#
#    Wait Until Keyword Succeeds   ${RETRY_AMOUNT}x    0.1 sec    Wait Until Page Contains    Password    0.5s
    Sleep    1s

Set Up Safari In IOS
    [Arguments]     ${PARALLEL_APPIUM_REMOTE_URL}    ${DEVICE_NAME_IOS}    ${PARALLEL_APPIUM_PORT}    ${PARALLEL_APPIUM_WDALOCALPORT}
    Open Application    ${PARALLEL_APPIUM_REMOTE_URL}    platformName=${PLATFORM_NAME_IOS}    platformVersion=${PLATFORM_VERSION_IOS}    devicetype=simulator
    ...    deviceName=${DEVICE_NAME_IOS}    PORT=${PARALLEL_APPIUM_PORT}    WDALOCALPORT=${PARALLEL_APPIUM_WDALOCALPORT}    automationName=${IOS_AUTOMATION_NAME}     startIWDP=true
    ...    browserName=Safari     bundleid=com.apple.mobilesafari
    Go To Url    %{APP_URL}
    Wait Until Keyword Succeeds   ${RETRY_AMOUNT}x    0.1 sec    Wait Until Page Contains    Password    0.5s
    Sleep    1s

Set Up Safari In IOS After Starting Charles Proxy
    [Timeout]    4 minutes
    [Arguments]     ${PARALLEL_APPIUM_REMOTE_URL}    ${DEVICE_NAME_IOS}    ${PARALLEL_APPIUM_PORT}    ${PARALLEL_APPIUM_WDALOCALPORT}    ${CHARLES_PROXY_APPIUM_EXAMPLE_URL}
    Run Process    ps aux | grep Charles     alias=charles_proxy_mac_os_status    shell=True    timeout=20s    on_timeout=continue
    ${CHARLES_PROXY_MAC_OS_STATUS}=   	Get Process Result    charles_proxy_mac_os_status    stdout=true
    Log    ${CHARLES_PROXY_MAC_OS_STATUS}
    Should Contain    ${CHARLES_PROXY_MAC_OS_STATUS}    Charles.app
    Run Keyword And Ignore Error    Open Application    ${PARALLEL_APPIUM_REMOTE_URL}    platformName=${PLATFORM_NAME_IOS}    platformVersion=${PLATFORM_VERSION_IOS}    devicetype=simulator
    ...    deviceName=${DEVICE_NAME_IOS}    PORT=${PARALLEL_APPIUM_PORT}    WDALOCALPORT=${PARALLEL_APPIUM_WDALOCALPORT}    automationName=${IOS_AUTOMATION_NAME}     startIWDP=true
    ...    browserName=Safari     bundleid=com.apple.mobilesafari
    Go To Url    ${CHARLES_PROXY_APPIUM_EXAMPLE_URL}
    Sleep    4s

Set Up Safari In IOS Before Starting Wireshark
    [Timeout]    4 minutes
    [Arguments]     ${PARALLEL_APPIUM_REMOTE_URL}    ${DEVICE_NAME_IOS}    ${PARALLEL_APPIUM_PORT}    ${PARALLEL_APPIUM_WDALOCALPORT}    ${WIRESHARK_APPIUM_EXAMPLE_URL}
    Run Process    ps aux | grep "[t]shark"     alias=wireshark_mac_os_status    shell=True    timeout=20s    on_timeout=continue
    ${WIRESHARK_MAC_OS_STATUS}=   	Get Process Result    wireshark_mac_os_status    stdout=true
    Log    ${WIRESHARK_MAC_OS_STATUS}
    Should Not Contain    ${WIRESHARK_MAC_OS_STATUS}    tshark
    Run Keyword And Ignore Error    Open Application    ${PARALLEL_APPIUM_REMOTE_URL}    platformName=${PLATFORM_NAME_IOS}    platformVersion=${PLATFORM_VERSION_IOS}    devicetype=simulator
    ...    deviceName=${DEVICE_NAME_IOS}    PORT=${PARALLEL_APPIUM_PORT}    WDALOCALPORT=${PARALLEL_APPIUM_WDALOCALPORT}    automationName=${IOS_AUTOMATION_NAME}     startIWDP=true
    ...    browserName=Safari     bundleid=com.apple.mobilesafari
    Go To Url    ${WIRESHARK_APPIUM_EXAMPLE_URL}
    Sleep    4s

Stop Any Running Android Emulators And Related Processes On MacOS
    Run Keyword And Ignore Error    Run    ANDROID_EMULATOR_PID=$(cat ./Workshop-Examples/Shared-Resources/android_emulator_PID.txt) && kill -s 9 $ANDROID_EMULATOR_PID
    Run Keyword And Ignore Error    Run    pgrep emulator | xargs kill
    Run Keyword And Ignore Error    Run    pgrep avd | xargs kill
    Run Keyword And Ignore Error    Run    adb kill-server
    Run Keyword And Ignore Error    Run    killall qemu-system-i386
    Run Keyword And Ignore Error    Run    killall adb

Click Sign Up Link
    Sleep    2s
    Click Element    //a[@href="/signup"]

Check The Sign Up Page
    Wait Until Keyword Succeeds   ${RETRY_AMOUNT}x    0.1 sec    Wait Until Page Contains    information    0.5s
    Sleep    2s

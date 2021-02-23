*** Settings ***
Documentation    Simple example using Wireshark and AppiumLibrary.
Resource         ${EXECDIR}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//Appium-Mobile-Resources.robot
Library          ${EXECDIR}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//WiresharkExample.py
Library          OperatingSystem
Library          Process

Suite Setup    Stop Any Running Android Emulators And Related Processes On MacOS

*** Variables ***
${PATH}    ${EXECDIR}
${WIRESHARK_APPIUM_EXAMPLE_URL}    https://www.youtube.com

*** Test Cases ***

WIRESHARK MOBILE TEST 1 - Go to a YouTube page in an iOS mobile browser while Wireshark is capturing packets on WiFi, then save it to a packet capture file.
    [Tags]    Mobile_Safari    Wireshark    Wireshark_IOS
    [Setup]    Navigate To Website Using Safari Then Run Wireshark
    Run Wireshark For WiFi Interface En0 And Create Packet Capture File
    [Teardown]    Close Applications And Terminate Wireshark Processes

WIRESHARK MOBILE TEST 2 - Go to a YouTube page in an iOS mobile browser while Wireshark is capturing packets on WiFi, then check the Loopback Interface.
    [Tags]    Mobile_Safari    Wireshark    Wireshark_IOS
    [Setup]    Navigate To Website Using Safari Then Run Wireshark
    Run Wireshark Live Packet Capture For Loopback Interface Lo0 And Check The Output
    [Teardown]    Close Applications And Terminate Wireshark Processes

WIRESHARK MOBILE TEST 3 - Go to a YouTube page in an iOS mobile browser while Wireshark is capturing packets, then run a Lua script to analyze the results.
    [Tags]    Mobile_Safari    Wireshark    Wireshark_IOS
    [Setup]    Navigate To Website Using Safari Then Run Wireshark
    Run Wireshark Lua Script And Check The Output
    [Teardown]    Close Applications And Terminate Wireshark Processes

WIRESHARK MOBILE TEST 4 - Decrypt a packet capture file with a wireshark-sslkeys.log file, then check the output.
    [Tags]    Mobile_Safari    Wireshark    Wireshark_IOS
    Run Wireshark To Decrypt Captured SSL Traffic And Check The Output
    [Teardown]    Terminate Wireshark Processes Multiple Times

*** Keywords ***

Run Wireshark To Decrypt Captured SSL Traffic And Check The Output
    ${WIRESHARK_DECRYPT_SSL_OUTPUT}=    Run Keyword    Wireshark Decrypt Captured SSL Traffic    wireshark-packets-captured.cap    20
    ${WIRESHARK_DECRYPT_SSL_RESULT}=    Convert To String    ${WIRESHARK_DECRYPT_SSL_OUTPUT}
    Log    ${WIRESHARK_DECRYPT_SSL_RESULT}
    Should Contain   ${WIRESHARK_DECRYPT_SSL_RESULT}    TCP

Run Wireshark Lua Script And Check The Output
    ${WIRESHARK_LUA_SCRIPT_OUTPUT}=    Run Keyword    Wireshark Lua Script    wireshark_lua_script.lua    2
    ${WIRESHARK_LUA_SCRIPT_RESULT}=    Convert To String    ${WIRESHARK_LUA_SCRIPT_OUTPUT}
    Log    ${WIRESHARK_LUA_SCRIPT_RESULT}
    Should Contain    ${WIRESHARK_LUA_SCRIPT_RESULT}    Number of packets captured for a given IP address

Run Wireshark Live Packet Capture For Loopback Interface Lo0 And Check The Output
    ${WIRESHARK_LIVE_CAPTURE_OUTPUT}=    Run Keyword    Wireshark Live Interface Packet Capture    lo0    5    5
    ${WIRESHARK_LIVE_CAPTURE_RESULT}=    Convert To String    ${WIRESHARK_LIVE_CAPTURE_OUTPUT}
    Log    ${WIRESHARK_LIVE_CAPTURE_RESULT}
    Should Contain    ${WIRESHARK_LIVE_CAPTURE_RESULT}    Layer

Run Wireshark For WiFi Interface En0 And Create Packet Capture File
    ${WIRESHARK_LIVE_FILE_CAPTURE_OUTPUT}=    Run Keyword    Wireshark Live Interface Capture To File    en0    5
    Log    ${WIRESHARK_LIVE_FILE_CAPTURE_OUTPUT}
    File Should Not Be Empty    ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//wireshark-packets-captured.cap

Terminate Wireshark Processes Multiple Times
    Run Keyword And Ignore Error    Repeat Keyword    3 times    Terminate All Wireshark Processes
    Run Keyword And Ignore Error    Run    killall tshark
    Sleep    5s

Open The Safari Browser In IOS After Wireshark Clean Up
    Set Suite Variable    ${PARALLEL_APPIUM_REMOTE_URL}    %{PARALLEL_APPIUM_REMOTE_URL1}
    Set Suite Variable    ${DEVICE_NAME_IOS}    %{DEVICE_NAME_IOS1}
    Set Suite Variable    ${PARALLEL_APPIUM_PORT}    %{PARALLEL_APPIUM_PORT1}
    Set Suite Variable    ${PARALLEL_APPIUM_WDALOCALPORT}     %{PARALLEL_APPIUM_WDALOCALPORT1}
    Should Not Be Empty     ${PARALLEL_APPIUM_REMOTE_URL}
    Should Not Be Empty     ${DEVICE_NAME_IOS}
    Should Not Be Empty     ${PARALLEL_APPIUM_PORT}
    Should Not Be Empty     ${PARALLEL_APPIUM_WDALOCALPORT}
    Run Keyword And Ignore Error    Set Up Safari In IOS Before Starting Wireshark    ${PARALLEL_APPIUM_REMOTE_URL}    ${DEVICE_NAME_IOS}    ${PARALLEL_APPIUM_PORT}    ${PARALLEL_APPIUM_WDALOCALPORT}    ${WIRESHARK_APPIUM_EXAMPLE_URL}

Navigate To Website Using Safari Then Run Wireshark
    Terminate Wireshark Processes Multiple Times
    Open The Safari Browser In IOS After Wireshark Clean Up
    Go To Url    https://www.youtube.com/watch?v=0yEnJt6Sf50&list=PLSK6YK5OGX1AZMAffD8EiTDq0lfzshRNg&autoplay=1

Close Applications And Terminate Wireshark Processes
    Close All Applications
    Run Keyword And Ignore Error    Terminate Wireshark Processes Multiple Times
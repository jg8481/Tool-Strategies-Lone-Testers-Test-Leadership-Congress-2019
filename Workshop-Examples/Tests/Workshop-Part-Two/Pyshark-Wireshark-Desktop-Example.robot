*** Settings ***
Documentation    Simple example using Wireshark and SeleniumLibrary.
Resource         ${EXECDIR}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//Selenium-Desktop-Resources.robot
Library          ${EXECDIR}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//WiresharkExample.py
Library          OperatingSystem
Library          Process

Suite Setup    Stop Any Running Android Emulators And Related Processes On MacOS

*** Variables ***
${PATH}    ${EXECDIR}
${WIRESHARK_SELENIUM_EXAMPLE_URL}    https://www.youtube.com/watch?v=wBhY5Z2RoqQ&feature=youtu.be&autoplay=1
${WIRESHARK_SELENIUM_BROWSER}    Firefox

*** Test Cases ***

WIRESHARK DESKTOP TEST 1 - Go to a YouTube page in a MacOS desktop browser while Wireshark is capturing packets on WiFi, then check the Loopback Interface.
    [Tags]    Desktop_Firefox    Wireshark    Wireshark_MacOS
    [Setup]    Navigate To Website Using Firefox Then Run Wireshark
    Run Wireshark Live Packet Capture For Loopback Interface Lo0 And Check The Output
    [Teardown]    Close Browser And Terminate Wireshark Processes

WIRESHARK DESKTOP TEST 2 - Go to a YouTube page in a MacOS desktop browser while Wireshark is capturing packets on WiFi, then save it to a packet capture file.
    [Tags]    Desktop_Firefox    Wireshark    Wireshark_MacOS
    [Setup]    Navigate To Website Using Firefox Then Run Wireshark
    Run Wireshark For WiFi Interface En0 And Create Packet Capture File
    [Teardown]    Close Browser And Terminate Wireshark Processes

WIRESHARK DESKTOP TEST 3 - Go to a YouTube page in a MacOS desktop browser while Wireshark is capturing packets, then run a Lua script to analyze the results.
    [Tags]    Desktop_Firefox    Wireshark    Wireshark_MacOS
    [Setup]    Navigate To Website Using Firefox Then Run Wireshark
    Run Wireshark Lua Script And Check The Output
    [Teardown]    Close Browser And Terminate Wireshark Processes

WIRESHARK DESKTOP TEST 4 - Decrypt a packet capture file with a wireshark-sslkeys.log file, then check the output.
    [Tags]    Desktop_Firefox    Wireshark    Wireshark_MacOS
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

Open The Firefox Browser In MacOS After Wireshark Clean Up
    Run Keyword And Ignore Error    Set Up Firefox In MacOS Before Starting Wireshark    ${WIRESHARK_SELENIUM_EXAMPLE_URL}    ${WIRESHARK_SELENIUM_BROWSER}

Navigate To Website Using Firefox Then Run Wireshark
    Terminate Wireshark Processes Multiple Times
    Open The Firefox Browser In MacOS After Wireshark Clean Up
    Press Keys    None    k

Close Browser And Terminate Wireshark Processes
    Close All Browsers
    Run Keyword And Ignore Error    Terminate Wireshark Processes Multiple Times
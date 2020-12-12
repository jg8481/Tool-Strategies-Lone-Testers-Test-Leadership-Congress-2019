*** Settings ***
Documentation                 This is a resource file that will provide common shared Robot Framework resources for using Wireshark in tests for Mac or Linux environments.
Library                       Collections
Library                       OperatingSystem
Library                       Process
Library                       String

*** Variables ***
${PATH}               ${EXECDIR}
${GLOBAL_RETRY_AMOUNT}    5

*** Keywords ***

Wireshark Live Interface Packet Capture
    [Arguments]    ${WIRESHARK_INTERFACE}    ${WIRESHARK_TIMEOUT}
    Run Process    tshark -i ${WIRESHARK_INTERFACE} -a duration:${WIRESHARK_TIMEOUT}    alias=wireshark_live_packet_capture    shell=True

Wireshark Live Interface Capture To File
    [Arguments]    ${WIRESHARK_INTERFACE}    ${WIRESHARK_TIMEOUT}
    Remove File    ${PATH}/Workshop-Examples/Tests/Workshop-Part-Two/Resources/wireshark-packets-captured.cap
    Run Process    tshark -i ${WIRESHARK_INTERFACE} -a duration:${WIRESHARK_TIMEOUT} -w ${PATH}/Workshop-Examples/Tests/Workshop-Part-Two/Resources/wireshark-packets-captured.cap    shell=True
    Sleep    ${WIRESHARK_TIMEOUT} seconds

Wireshark Lua Script
    [Arguments]    ${WIRESHARK_LUA_SCRIPT_FILE}    ${WIRESHARK_PACKET_AMOUNT}
    Run Process    tshark -X lua_script:${PATH}/Workshop-Examples/Tests/Workshop-Part-Two/Resources/${WIRESHARK_LUA_SCRIPT_FILE} -c ${WIRESHARK_PACKET_AMOUNT}    alias=wireshark_lua_script    shell=True

Wireshark Decrypt Captured SSL Traffic
    [Arguments]    ${WIRESHARK_CAPTURE_FILE}    ${WIRESHARK_SSL_KEYS_FILE}    ${WIRESHARK_PACKET_AMOUNT}
    Run Process    tshark -nr ${PATH}/Workshop-Examples/Tests/Workshop-Part-Two/Resources/${WIRESHARK_CAPTURE_FILE} -o tls.keylog_file:${PATH}/Workshop-Examples/Tests/Workshop-Part-Two/Resources/${WIRESHARK_SSL_KEYS_FILE} -c ${WIRESHARK_PACKET_AMOUNT}    alias=wireshark_decrypt_traffic    shell=True

Terminate All Wireshark Processes
    Terminate All Processes

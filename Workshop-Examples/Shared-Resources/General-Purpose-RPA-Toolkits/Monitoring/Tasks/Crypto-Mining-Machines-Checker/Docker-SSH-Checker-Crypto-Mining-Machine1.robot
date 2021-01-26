*** Settings ***

Library    SSHLibrary
Library    Process

*** Tasks ***

Check first target crypto mining machine and send a Slack notification.
    [Tags]    Remote_Crypto_Mining_Machine_One    Remote_Crypto_Mining_Machines
    [Setup]    Connect To Crypto Mining Machine One
    Run Checks On Mining Machine One And Send Slack Messages
    [Teardown]    Close Connection

*** Keywords ***

Connect To Crypto Mining Machine One
    [Timeout]    2 minutes
    Open Connection    %{SSH_HOST1}
    Login    %{SSH_USERNAME1}    %{SSH_PASSWORD1}

Run Checks On Mining Machine One And Send Slack Messages
    Run Keyword And Continue On Failure    Check Remote Mining Machine One For Ethminer    echo; echo; top -n 1 -b | head -12
    Check Mining Machine One Status And Send Slack Notification    Ethereum    ethminer

Check Remote Mining Machine One For Ethminer
    [Arguments]    ${MACHINE_ONE_PROCESS}
    [Timeout]    1 minute
    Set Suite Variable    ${MACHINE_ONE_STATUS_CHECK}    WARNING: Problems detected!!! Check this machine!!!
    ${MACHINE_ONE_PROCESS_OUTPUT}=    Execute Command    ${MACHINE_ONE_PROCESS}
    Should Not Be Empty    ${MACHINE_ONE_PROCESS_OUTPUT}
    Should Contain    ${MACHINE_ONE_PROCESS_OUTPUT}    USER
    ${MACHINE_ONE_MINER_OUTPUT}=    Execute Command    ./ethminer -v
    Should Contain    ${MACHINE_ONE_MINER_OUTPUT}    linux/release/gnu
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    Mining machine tool output.
    Log    ${MACHINE_ONE_MINER_OUTPUT}
    Log To Console    ${MACHINE_ONE_MINER_OUTPUT}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    Mining machine CPU, Memory, User and Process information.
    Log    ${MACHINE_ONE_PROCESS_OUTPUT}
    Log To Console    ${MACHINE_ONE_PROCESS_OUTPUT}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Set Suite Variable    ${MACHINE_ONE_STATUS_CHECK}    SUCCESS: All checks passed. Let's make money! ^_^

Check Mining Machine One Status And Send Slack Notification
    [Arguments]    ${CRYPTOCURRENCY_NAME}    ${CRYPTO_MINING_TOOL}
    Run Process    echo "Machine One is mining ${CRYPTOCURRENCY_NAME} and is running ${CRYPTO_MINING_TOOL}. It was checked and this is the current status --> ${MACHINE_ONE_STATUS_CHECK} " | slacktee.sh -i :nerd_face: --plain-text --config /rfw/Tasks/Crypto-Mining-Machines-Checker/.slacktee    shell=True    timeout=20s    on_timeout=continue

*** Settings ***

Library    SSHLibrary
Library    Process

*** Tasks ***

Check second target crypto mining machine and send a Slack notification.
    [Tags]    Remote_Crypto_Mining_Machine_Two    Remote_Crypto_Mining_Machines
    [Setup]    Connect To Crypto Mining Machine Two
    Run Checks On Mining Machine Two And Send Slack Messages
    [Teardown]    Close Connection

*** Keywords ***

Connect To Crypto Mining Machine Two
    [Timeout]    2 minutes
    Open Connection    %{SSH_HOST2}
    Login    %{SSH_USERNAME2}    %{SSH_PASSWORD2}

Run Checks On Mining Machine Two And Send Slack Messages
    Run Keyword And Continue On Failure    Check Remote Mining Machine Two For Ethminer    echo; echo; top -n 1 -b | head -12
    Check Mining Machine Two Status And Send Slack Notification    Ethereum    ethminer

Check Remote Mining Machine Two For Ethminer
    [Arguments]    ${MACHINE_TWO_PROCESS}
    [Timeout]    1 minute
    Set Suite Variable    ${MACHINE_TWO_STATUS_CHECK}    WARNING: Problems detected!!! Check this machine!!!
    ${MACHINE_TWO_PROCESS_OUTPUT}=    Execute Command    ${MACHINE_TWO_PROCESS}
    Should Not Be Empty    ${MACHINE_TWO_PROCESS_OUTPUT}
    Should Contain    ${MACHINE_TWO_PROCESS_OUTPUT}    USER
    ${MACHINE_TWO_MINER_OUTPUT}=    Execute Command    ./ethminer -v
    Should Contain    ${MACHINE_TWO_MINER_OUTPUT}    linux/release/gnu
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    Mining machine tool output.
    Log    ${MACHINE_TWO_MINER_OUTPUT}
    Log To Console    ${MACHINE_TWO_MINER_OUTPUT}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    Mining machine CPU, Memory, User and Process information.
    Log    ${MACHINE_TWO_PROCESS_OUTPUT}
    Log To Console    ${MACHINE_TWO_PROCESS_OUTPUT}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Set Suite Variable    ${MACHINE_TWO_STATUS_CHECK}    SUCCESS: All checks passed. Let's make money! ^_^

Check Mining Machine Two Status And Send Slack Notification
    [Arguments]    ${CRYPTOCURRENCY_NAME}    ${CRYPTO_MINING_TOOL}
    Run Process    echo "Machine Two is mining ${CRYPTOCURRENCY_NAME} and is running ${CRYPTO_MINING_TOOL}. It was checked and this is the current status --> ${MACHINE_TWO_STATUS_CHECK} " | slacktee.sh -i :nerd_face: --plain-text --config /rfw/Tasks/Crypto-Mining-Machines-Checker/.slacktee    shell=True    timeout=20s    on_timeout=continue

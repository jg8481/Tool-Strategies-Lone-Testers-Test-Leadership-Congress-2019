*** Settings ***

Documentation     Part Two of the Postman Newman example has been enhanced by using the Shared-Keywords-And-Listeners.robot resource file to add 2 types of Robot Framework listeners and a team notification keyword.
...               Also added the "--randomize tests" option in the commands-running-inside-a-docker-container.sh script, and will demonstrate the use of the "--rerunfailedsuites".

Library           OperatingSystem
Library           Process

Resource          ${EXECDIR}//Shared-Resources//Shared-Keywords-And-Listeners.robot

Test Teardown     Trigger Only After Failure

*** Variables ***
${PATH}    ${EXECDIR}//Tests//Workshop-Part-Two//Resources

*** Test Cases ***

POSTMAN NEWMAN COLLECTION EXAMPLE PART TWO : Send a POST request to jsonplaceholder.typicode.com/posts and check the response.
    Run Process    newman run ${PATH}//jsonplaceholder.typicode.com.postman_collection.json --folder 'Send POST to jsonplaceholder.typicode.com' --reporter-cli-no-summary --color off --reporter-cli-no-console     alias=postman_post    shell=True    timeout=20s    on_timeout=continue
    ${POSTMAN_POST_RESPONSE}=   	Get Process Result    postman_post    stdout=true
    Log    ${POSTMAN_POST_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${POSTMAN_POST_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Contain    ${POSTMAN_POST_RESPONSE}    201 Created
    [Tags]    Regression_Tests    Unrefined_And_Created_In_A_Hurry

POSTMAN NEWMAN COLLECTION EXAMPLE PART TWO : Send a PATCH request to "title" for jsonplaceholder.typicode.com/posts/1 and check the response.
    Run Process    newman run ${PATH}//jsonplaceholder.typicode.com.postman_collection.json --folder 'Send PATCH to jsonplaceholder.typicode.com' --reporter-cli-no-summary --color off --reporter-cli-no-console    alias=postman_patch    shell=True    timeout=20s    on_timeout=continue
    ${POSTMAN_PATCH_RESPONSE}=   	Get Process Result    postman_patch    stdout=true
    Log    ${POSTMAN_PATCH_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${POSTMAN_PATCH_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    ## This will make the test fail. We are doing this to trigger the rerunner and the team notification keyword.
    Should Not Contain    ${POSTMAN_PATCH_RESPONSE}    200 OK
    [Tags]    Regression_Tests    Unrefined_And_Created_In_A_Hurry

POSTMAN NEWMAN COLLECTION EXAMPLE PART TWO : Send a GET request to jsonplaceholder.typicode.com/posts/1 and check the response.
    Run Process    newman run ${PATH}//jsonplaceholder.typicode.com.postman_collection.json --folder 'Send GET to jsonplaceholder.typicode.com' --reporter-cli-no-summary --color off --reporter-cli-no-console    alias=postman_get    shell=True    timeout=20s    on_timeout=continue
    ${POSTMAN_GET_RESPONSE}=   	Get Process Result    postman_get    stdout=true
    Log    ${POSTMAN_GET_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${POSTMAN_GET_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Contain    ${POSTMAN_GET_RESPONSE}    200 OK
    [Tags]    Regression_Tests    Unrefined_And_Created_In_A_Hurry

POSTMAN NEWMAN COLLECTION EXAMPLE PART TWO : Send a DELETE request to jsonplaceholder.typicode.com/posts/1 and check the response.
    Run Process    newman run ${PATH}//jsonplaceholder.typicode.com.postman_collection.json --folder 'Send DELETE to jsonplaceholder.typicode.com' --reporter-cli-no-summary --color off --reporter-cli-no-console    alias=postman_delete    shell=True    timeout=20s    on_timeout=continue
    ${POSTMAN_DELETE_RESPONSE}=   	Get Process Result    postman_delete    stdout=true
    Log    ${POSTMAN_DELETE_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${POSTMAN_DELETE_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Contain    ${POSTMAN_DELETE_RESPONSE}    200 OK
    [Tags]    Regression_Tests    Unrefined_And_Created_In_A_Hurry

*** Keywords ***

Trigger Only After Failure
    Run Keyword If Test Failed     Failure Detected Notify Team

Failure Detected Notify Team
    Send Short Message Through Slack And Email    regression tests in the Docker-Example-Postman-Newman-Enhanced-Version.robot file    ${TEST_ENVIRONMENT}

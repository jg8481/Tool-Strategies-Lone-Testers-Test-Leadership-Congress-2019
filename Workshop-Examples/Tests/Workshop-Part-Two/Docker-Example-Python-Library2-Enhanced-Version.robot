*** Settings ***

Documentation     Part Two of the Python Library example has been enhanced by using the SharedKeywordsAndListeners.robot resource file to add 2 types of Robot Framework listeners and a team notification keyword.
...               Also added the "--randomize all" option in the commands-running-inside-a-docker-container.sh script, and will demonstrate the use of the "--rerunfailedsuites" option.

Library           Collections
Library           ${EXECDIR}//Tests//Workshop-Part-Two//Resources//DockerExample.py

Resource          ${EXECDIR}//Shared-Resources//SharedKeywordsAndListeners.robot
Test Teardown     Trigger Only After Failure

*** Test Cases ***

USER-CREATED PYTHON LIBRARY EXAMPLE PART TWO - ROBOT FILE TWO : Send a PUT request to jsonplaceholder.typicode.com/posts and check the response.
    ${PYTHON_LIBRARY_ROBOT_FILE_TWO_POST_RESPONSE}=    Send Put Request Robot File Two
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${PYTHON_LIBRARY_ROBOT_FILE_TWO_POST_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${PYTHON_LIBRARY_ROBOT_FILE_TWO_POST_RESPONSE.json()}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${PYTHON_LIBRARY_ROBOT_FILE_TWO_POST_RESPONSE.status_code}    200
    Dictionary Should Contain Key    ${PYTHON_LIBRARY_ROBOT_FILE_TWO_POST_RESPONSE.json()}    id
    ${POST_RESPONSE_VALUES}=     Get Dictionary Values    ${PYTHON_LIBRARY_ROBOT_FILE_TWO_POST_RESPONSE.json()}
    Should Be Equal As Strings    ${POST_RESPONSE_VALUES}    [2]
    [Tags]    Regression_Tests    Slightly_Refined_And_Room_For_Enhancements

USER-CREATED PYTHON LIBRARY EXAMPLE PART TWO - ROBOT FILE TWO : Send a PATCH request to "body" for jsonplaceholder.typicode.com/posts/2 and check the response.
    ${PYTHON_LIBRARY_ROBOT_FILE_TWO_PATCH_RESPONSE}=    Send Patch Request Robot File Two
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${PYTHON_LIBRARY_ROBOT_FILE_TWO_PATCH_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${PYTHON_LIBRARY_ROBOT_FILE_TWO_PATCH_RESPONSE.json()}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${PYTHON_LIBRARY_ROBOT_FILE_TWO_PATCH_RESPONSE.status_code}    200
    Dictionary Should Contain Value    ${PYTHON_LIBRARY_ROBOT_FILE_TWO_PATCH_RESPONSE.json()}    Testing with Robot Framework.
    [Tags]    Regression_Tests    Slightly_Refined_And_Room_For_Enhancements

USER-CREATED PYTHON LIBRARY EXAMPLE PART TWO - ROBOT FILE TWO : Send a GET request to jsonplaceholder.typicode.com/posts/2 and check the response.
    ${PYTHON_LIBRARY_ROBOT_FILE_TWO_GET_RESPONSE}=    Send Get Request Robot File Two
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${PYTHON_LIBRARY_ROBOT_FILE_TWO_GET_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${PYTHON_LIBRARY_ROBOT_FILE_TWO_GET_RESPONSE.json()}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${PYTHON_LIBRARY_ROBOT_FILE_TWO_GET_RESPONSE.status_code}    200
    Dictionary Should Contain Value    ${PYTHON_LIBRARY_ROBOT_FILE_TWO_GET_RESPONSE.json()}    qui est esse
    Dictionary Should Not Contain Value    ${PYTHON_LIBRARY_ROBOT_FILE_TWO_GET_RESPONSE.json()}    Testing with Robot Framework.
    [Tags]    Regression_Tests    Slightly_Refined_And_Room_For_Enhancements

USER-CREATED PYTHON LIBRARY EXAMPLE PART TWO - ROBOT FILE TWO : Send a DELETE request to jsonplaceholder.typicode.com/posts/2 and check the response.
    ${PYTHON_LIBRARY_ROBOT_FILE_TWO_DELETE_RESPONSE}=    Send Delete Request Robot File Two
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${PYTHON_LIBRARY_ROBOT_FILE_TWO_DELETE_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    ## This will make the test fail. We are doing this to trigger the rerunner and the team notification keyword.
    Should Not Be Equal As Strings    ${PYTHON_LIBRARY_ROBOT_FILE_TWO_DELETE_RESPONSE.status_code}    200
    Should Be Empty    ${PYTHON_LIBRARY_ROBOT_FILE_TWO_DELETE_RESPONSE.json()}
    [Tags]    Regression_Tests    Slightly_Refined_And_Room_For_Enhancements

*** Keywords ***

Trigger Only After Failure
    Run Keyword If Test Failed     Failure Detected Notify Team

Failure Detected Notify Team
    Send Short Message Through Slack And Email    regression tests in the Docker-Example-Python-Library2-Enhanced-Version.robot file    ${TEST_ENVIRONMENT}

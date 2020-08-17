*** Settings ***

Documentation     Part Two of the Python Library example has been enhanced by using the Shared-Keywords-And-Listeners.robot resource file to add 2 types of Robot Framework listeners and a team notification keyword.
...               Also added the "--randomize all" option in the commands-running-inside-a-docker-container.sh script, and will demonstrate the use of the "--rerunfailedsuites".

Library           Collections
Library           ${EXECDIR}//Tests//Workshop-Part-Two//Resources//DockerExample.py

Resource          ${EXECDIR}//Shared-Resources//Shared-Keywords-And-Listeners.robot
Test Teardown     Trigger Only After Failure

*** Test Cases ***

USER-CREATED PYTHON LIBRARY EXAMPLE PART TWO - ROBOT FILE ONE : Send a POST request to jsonplaceholder.typicode.com/posts and check the response.
    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_POST_RESPONSE}=    Send Post Request Robot File One
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_POST_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_POST_RESPONSE.json()}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_POST_RESPONSE.status_code}    201
    Dictionary Should Contain Key    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_POST_RESPONSE.json()}    id
    ${POST_RESPONSE_VALUES}=     Get Dictionary Values    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_POST_RESPONSE.json()}
    Should Be Equal As Strings    ${POST_RESPONSE_VALUES}    [101]
    [Tags]    Regression_Tests    Slightly_Refined_And_Room_For_Enhancements

USER-CREATED PYTHON LIBRARY EXAMPLE PART TWO - ROBOT FILE ONE : Send a PATCH request to "title" for jsonplaceholder.typicode.com/posts/1 and check the response.
    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_PATCH_RESPONSE}=    Send Patch Request Robot File One
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_PATCH_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_PATCH_RESPONSE.json()}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_PATCH_RESPONSE.status_code}    200
    Dictionary Should Contain Value    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_PATCH_RESPONSE.json()}    Testing with Robot Framework.
    [Tags]    Regression_Tests    Slightly_Refined_And_Room_For_Enhancements

USER-CREATED PYTHON LIBRARY EXAMPLE PART TWO - ROBOT FILE ONE : Send a GET request to jsonplaceholder.typicode.com/posts/1 and check the response.
    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_GET_RESPONSE}=    Send Get Request Robot File One
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_GET_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_GET_RESPONSE.json()}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    ## This will make the test fail. We are doing this to trigger the rerunner and the team notification keyword.
    Should Not Be Equal As Strings    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_GET_RESPONSE.status_code}    200
    Dictionary Should Contain Value    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_GET_RESPONSE.json()}    quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto
    Dictionary Should Not Contain Value    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_GET_RESPONSE.json()}    Testing with Robot Framework.
    [Tags]    Regression_Tests    Slightly_Refined_And_Room_For_Enhancements

USER-CREATED PYTHON LIBRARY EXAMPLE PART TWO - ROBOT FILE ONE : Send a DELETE request to jsonplaceholder.typicode.com/posts/1 and check the response.
    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_DELETE_RESPONSE}=    Send Delete Request Robot File One
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_DELETE_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_DELETE_RESPONSE.status_code}    200
    Should Be Empty    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_DELETE_RESPONSE.json()}
    [Tags]    Regression_Tests    Slightly_Refined_And_Room_For_Enhancements

*** Keywords ***

Trigger Only After Failure
    Run Keyword If Test Failed     Failure Detected Notify Team

Failure Detected Notify Team
    Send Short Message Through Slack And Email    regression tests in the Docker-Example-Python-Library1-Enhanced-Version.robot file    ${TEST_ENVIRONMENT}

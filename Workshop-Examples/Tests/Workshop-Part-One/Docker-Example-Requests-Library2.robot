*** Settings ***

Documentation    In a hypothetical scenario, where you are split between 3 or more frequently changing projects. Maybe you were able to convince your team leaders and developers
...              to let you try out a different and more refined approach for building out your Robot Framework regression tests. The following assumes that your team is comfortable
...              with looking at and contributing to a test that is mostly written using keywords from a Robot Framework test library. In this case the robotframework-requests library...

Library          Collections
Library          OperatingSystem
Library          RequestsLibrary

*** Variables ***
${PATH}          ${EXECDIR}//Tests//Workshop-Part-One//Resources

*** Test Cases ***

REQUESTS LIBRARY EXAMPLE PART ONE - ROBOT FILE TWO : Send a PUT request to jsonplaceholder.typicode.com/posts and check the response.
    ${HEADERS}=       Create Dictionary    Content-Type    application/json
    Create Session    jsonplaceholder    http://${BASE_URL}    headers=${HEADERS}
    ${REQUESTS_LIBRARY_ROBOT_FILE_TWO_PUT_RESPONSE}=    Put Request    jsonplaceholder    /posts/2
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${REQUESTS_LIBRARY_ROBOT_FILE_TWO_PUT_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${REQUESTS_LIBRARY_ROBOT_FILE_TWO_PUT_RESPONSE.json()}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${REQUESTS_LIBRARY_ROBOT_FILE_TWO_PUT_RESPONSE.status_code}    200
    Dictionary Should Contain Key    ${REQUESTS_LIBRARY_ROBOT_FILE_TWO_PUT_RESPONSE.json()}    id
    ${PUT_RESPONSE_VALUES}=     Get Dictionary Values    ${REQUESTS_LIBRARY_ROBOT_FILE_TWO_PUT_RESPONSE.json()}
    Should Be Equal As Strings    ${PUT_RESPONSE_VALUES}    [2]
    [Tags]    Regression_Tests    Slightly_Refined_And_Room_For_Enhancements

REQUESTS LIBRARY EXAMPLE PART ONE - ROBOT FILE TWO : Send a PATCH request to "body" for jsonplaceholder.typicode.com/posts/2 and check the response.
    ${HEADERS}=       Create Dictionary    Content-Type    application/json
    Create Session    jsonplaceholder    http://${BASE_URL}    headers=${HEADERS}
    ${REQUESTS_LIBRARY_ROBOT_FILE_TWO_PATCH_RESPONSE}=    Patch Request    jsonplaceholder    /posts/2    data={"body":"Testing with Robot Framework."}    headers=${HEADERS}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${REQUESTS_LIBRARY_ROBOT_FILE_TWO_PATCH_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${REQUESTS_LIBRARY_ROBOT_FILE_TWO_PATCH_RESPONSE.json()}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${REQUESTS_LIBRARY_ROBOT_FILE_TWO_PATCH_RESPONSE.status_code}    200
    Dictionary Should Contain Value    ${REQUESTS_LIBRARY_ROBOT_FILE_TWO_PATCH_RESPONSE.json()}    Testing with Robot Framework.
    [Tags]    Regression_Tests    Slightly_Refined_And_Room_For_Enhancements

REQUESTS LIBRARY EXAMPLE PART ONE - ROBOT FILE TWO : Send a GET request to jsonplaceholder.typicode.com/posts/2 and check the response.
    ${HEADERS}=       Create Dictionary    Content-Type    application/json
    Create Session    jsonplaceholder    http://${BASE_URL}    headers=${HEADERS}
    ${REQUESTS_LIBRARY_ROBOT_FILE_TWO_GET_RESPONSE}=    Get Request    jsonplaceholder    /posts/2    headers=${HEADERS}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${REQUESTS_LIBRARY_ROBOT_FILE_TWO_GET_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${REQUESTS_LIBRARY_ROBOT_FILE_TWO_GET_RESPONSE.json()}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${REQUESTS_LIBRARY_ROBOT_FILE_TWO_GET_RESPONSE.status_code}    200
    Dictionary Should Contain Value    ${REQUESTS_LIBRARY_ROBOT_FILE_TWO_GET_RESPONSE.json()}    qui est esse
    Dictionary Should Not Contain Value    ${REQUESTS_LIBRARY_ROBOT_FILE_TWO_GET_RESPONSE.json()}    Testing with Robot Framework.
    [Tags]    Regression_Tests    Slightly_Refined_And_Room_For_Enhancements

REQUESTS LIBRARY EXAMPLE PART ONE - ROBOT FILE TWO : Send a DELETE request to jsonplaceholder.typicode.com/posts/2 and check the response.
    ${HEADERS}=       Create Dictionary    Content-Type    application/json
    Create Session    jsonplaceholder    http://${BASE_URL}    headers=${HEADERS}
    ${REQUESTS_LIBRARY_ROBOT_FILE_TWO_DELETE_RESPONSE}=    Delete Request    jsonplaceholder    /posts/2    headers=${HEADERS}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${REQUESTS_LIBRARY_ROBOT_FILE_TWO_DELETE_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${REQUESTS_LIBRARY_ROBOT_FILE_TWO_DELETE_RESPONSE.status_code}    200
    Should Be Empty     ${REQUESTS_LIBRARY_ROBOT_FILE_TWO_DELETE_RESPONSE.json()}
    [Tags]    Regression_Tests    Slightly_Refined_And_Room_For_Enhancements

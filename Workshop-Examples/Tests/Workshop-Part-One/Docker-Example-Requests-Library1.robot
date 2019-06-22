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

REQUESTS LIBRARY EXAMPLE PART ONE - ROBOT FILE ONE : Send a POST request to jsonplaceholder.typicode.com/posts and check the response.
    ${HEADERS}=       Create Dictionary    Content-Type    application/json
    Create Session    jsonplaceholder    http://${BASE_URL}    headers=${HEADERS}
    ${REQUESTS_LIBRARY_ROBOT_FILE_ONE_POST_RESPONSE}=    Post Request    jsonplaceholder    /posts    headers=${HEADERS}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${REQUESTS_LIBRARY_ROBOT_FILE_ONE_POST_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${REQUESTS_LIBRARY_ROBOT_FILE_ONE_POST_RESPONSE.json()}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${REQUESTS_LIBRARY_ROBOT_FILE_ONE_POST_RESPONSE.status_code}    201
    Dictionary Should Contain Key    ${REQUESTS_LIBRARY_ROBOT_FILE_ONE_POST_RESPONSE.json()}    id
    ${POST_RESPONSE_VALUES}=     Get Dictionary Values    ${REQUESTS_LIBRARY_ROBOT_FILE_ONE_POST_RESPONSE.json()}
    Should Be Equal As Strings    ${POST_RESPONSE_VALUES}    [101]
    [Tags]    Regression_Tests    Slightly_Refined_And_Room_For_Enhancements

REQUESTS LIBRARY EXAMPLE PART ONE - ROBOT FILE ONE : Send a PATCH request to "title" for jsonplaceholder.typicode.com/posts/1 and check the response.
    ${HEADERS}=       Create Dictionary    Content-Type    application/json
    Create Session    jsonplaceholder    http://${BASE_URL}    headers=${HEADERS}
    ${REQUESTS_LIBRARY_ROBOT_FILE_ONE_PATCH_RESPONSE}=    Patch Request    jsonplaceholder    /posts/1    data={"title":"Testing with Robot Framework."}    headers=${HEADERS}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${REQUESTS_LIBRARY_ROBOT_FILE_ONE_PATCH_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${REQUESTS_LIBRARY_ROBOT_FILE_ONE_PATCH_RESPONSE.json()}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${REQUESTS_LIBRARY_ROBOT_FILE_ONE_PATCH_RESPONSE.status_code}    200
    Dictionary Should Contain Value    ${REQUESTS_LIBRARY_ROBOT_FILE_ONE_PATCH_RESPONSE.json()}    Testing with Robot Framework.
    [Tags]    Regression_Tests    Slightly_Refined_And_Room_For_Enhancements

REQUESTS LIBRARY EXAMPLE PART ONE - ROBOT FILE ONE : Send a GET request to jsonplaceholder.typicode.com/posts/1 and check the response.
    ${HEADERS}=       Create Dictionary    Content-Type    application/json
    Create Session    jsonplaceholder    http://${BASE_URL}    headers=${HEADERS}
    ${REQUESTS_LIBRARY_ROBOT_FILE_ONE_GET_RESPONSE}=    Get Request    jsonplaceholder    /posts/1    headers=${HEADERS}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${REQUESTS_LIBRARY_ROBOT_FILE_ONE_GET_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${REQUESTS_LIBRARY_ROBOT_FILE_ONE_GET_RESPONSE.json()}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${REQUESTS_LIBRARY_ROBOT_FILE_ONE_GET_RESPONSE.status_code}    200
    Dictionary Should Contain Value    ${REQUESTS_LIBRARY_ROBOT_FILE_ONE_GET_RESPONSE.json()}    quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto
    Dictionary Should Not Contain Value    ${REQUESTS_LIBRARY_ROBOT_FILE_ONE_GET_RESPONSE.json()}    Testing with Robot Framework.
    [Tags]    Regression_Tests    Slightly_Refined_And_Room_For_Enhancements

REQUESTS LIBRARY EXAMPLE PART ONE - ROBOT FILE ONE : Send a DELETE request to jsonplaceholder.typicode.com/posts/1 and check the response.
    ${HEADERS}=       Create Dictionary    Content-Type    application/json
    Create Session    jsonplaceholder    http://${BASE_URL}    headers=${HEADERS}
    ${REQUESTS_LIBRARY_ROBOT_FILE_ONE_DELETE_RESPONSE}=    Delete Request    jsonplaceholder    /posts/1    headers=${HEADERS}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${REQUESTS_LIBRARY_ROBOT_FILE_ONE_DELETE_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${REQUESTS_LIBRARY_ROBOT_FILE_ONE_DELETE_RESPONSE.status_code}    200
    Should Be Empty    ${REQUESTS_LIBRARY_ROBOT_FILE_ONE_DELETE_RESPONSE.json()}
    [Tags]    Regression_Tests    Slightly_Refined_And_Room_For_Enhancements

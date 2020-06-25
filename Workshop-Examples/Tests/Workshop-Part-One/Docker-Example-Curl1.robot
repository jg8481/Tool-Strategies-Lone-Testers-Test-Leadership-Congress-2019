*** Settings ***

Documentation    In a hypothetical scenario, where you are split between 3 or more frequently changing projects. Several of them are maybe, days, weeks or months past their delivery date.
...              You are brought in to quickly learn everything about the project and set up basic regression tests touching all of the high risk areas, running in the CI pipeline in less than 10 working
...              days (ideally they want it in probably 5 days or less). This might be a situation where people are relying on various types of tools to test things out and quickly explore system behavior,
...              maybe there are dozens of cURL one-liners being shared by the developers...

Library          Process

*** Test Cases ***

CURL EXAMPLE PART ONE - ROBOT FILE ONE : Send a POST request to jsonplaceholder.typicode.com/posts and check the response.
    Run Process    curl -i -X POST -H 'Content-Type: application/json' http://${BASE_URL}/posts/    alias=curl_robot_file_one_post    shell=True    timeout=20s    on_timeout=continue
    ${CURL_ROBOT_FILE_ONE_POST_RESPONSE}=   	Get Process Result    curl_robot_file_one_post    stdout=true
    Log    ${CURL_ROBOT_FILE_ONE_POST_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${CURL_ROBOT_FILE_ONE_POST_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Contain    ${CURL_ROBOT_FILE_ONE_POST_RESPONSE}    201
    Should Contain    ${CURL_ROBOT_FILE_ONE_POST_RESPONSE}    "id": 101   ignore_case=True
    [Tags]    Regression_Tests    Unrefined_And_Created_In_A_Hurry

CURL EXAMPLE PART ONE - ROBOT FILE ONE : Send a PATCH request to "title" for jsonplaceholder.typicode.com/posts/1 and check the response.
    Run Process    curl -i -X PATCH -H 'Content-Type: application/json' http://${BASE_URL}/posts/1 -d '{"title":"Testing with Robot Framework."}'    alias=curl_robot_file_one_patch    shell=True    timeout=20s    on_timeout=continue
    ${CURL_ROBOT_FILE_ONE_PATCH_RESPONSE}=   	Get Process Result    curl_robot_file_one_patch    stdout=true
    Log    ${CURL_ROBOT_FILE_ONE_PATCH_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${CURL_ROBOT_FILE_ONE_PATCH_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Contain    ${CURL_ROBOT_FILE_ONE_PATCH_RESPONSE}    200
    Should Contain    ${CURL_ROBOT_FILE_ONE_PATCH_RESPONSE}    "title": "Testing with Robot Framework."    ignore_case=True
    [Tags]    Regression_Tests    Unrefined_And_Created_In_A_Hurry

CURL EXAMPLE PART ONE - ROBOT FILE ONE : Send a GET request to jsonplaceholder.typicode.com/posts/1 and check the response.
    Run Process    curl -i -H 'Content-Type: application/json' http://${BASE_URL}/posts/1    alias=curl_robot_file_one_get    shell=True    timeout=20s    on_timeout=continue
    ${CURL_ROBOT_FILE_ONE_GET_RESPONSE}=   	Get Process Result    curl_robot_file_one_get    stdout=true
    Log    ${CURL_ROBOT_FILE_ONE_GET_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${CURL_ROBOT_FILE_ONE_GET_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Contain    ${CURL_ROBOT_FILE_ONE_GET_RESPONSE}    200
    Should Contain    ${CURL_ROBOT_FILE_ONE_GET_RESPONSE}    "id": 1    ignore_case=True
    Should Not Contain    ${CURL_ROBOT_FILE_ONE_GET_RESPONSE}    Testing with Robot Framework    ignore_case=True
    [Tags]    Regression_Tests    Unrefined_And_Created_In_A_Hurry

CURL EXAMPLE PART ONE - ROBOT FILE ONE : Send a DELETE request to jsonplaceholder.typicode.com/posts/1 and check the response.
    Run Process    curl -i -X DELETE -H 'Content-Type: application/json' http://${BASE_URL}/posts/1    alias=curl_robot_file_one_delete    shell=True    timeout=20s    on_timeout=continue
    ${CURL_ROBOT_FILE_ONE_DELETE_RESPONSE}=   	Get Process Result    curl_robot_file_one_delete    stdout=true
    Log    ${CURL_ROBOT_FILE_ONE_DELETE_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${CURL_ROBOT_FILE_ONE_DELETE_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Contain    ${CURL_ROBOT_FILE_ONE_DELETE_RESPONSE}    200
    Should Contain    ${CURL_ROBOT_FILE_ONE_DELETE_RESPONSE}    {}    ignore_case=True
    Should Not Contain    ${CURL_ROBOT_FILE_ONE_DELETE_RESPONSE}    "id": 1    ignore_case=True
    [Tags]    Regression_Tests    Unrefined_And_Created_In_A_Hurry

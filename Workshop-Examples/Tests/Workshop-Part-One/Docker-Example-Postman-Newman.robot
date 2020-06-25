*** Settings ***

Documentation    In a hypothetical scenario, where you are split between 3 or more frequently changing projects. Several of them are maybe, days, weeks or months past their delivery date.
...              You are brought in to quickly learn everything about the project and set up basic regression tests touching all of the high risk areas, running in the CI pipeline in less than 10 working
...              days (ideally they want it in probably 5 days or less). This might be a situation where people are relying on various types of tools to test things out and quickly explore system behavior,
...              maybe all of the developers like using Postman (with Newman) and are sharing a single Postman Collection that keeps growing bigger every day. This example is enhanced in Part Two...

Library          OperatingSystem
Library          Process

*** Variables ***
${PATH}          ${EXECDIR}//Tests//Workshop-Part-One//Resources

*** Test Cases ***

POSTMAN NEWMAN COLLECTION EXAMPLE PART ONE : Send a POST request to jsonplaceholder.typicode.com/posts and check the response.
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

POSTMAN NEWMAN COLLECTION EXAMPLE PART ONE : Send a PATCH request to "title" for jsonplaceholder.typicode.com/posts/1 and check the response.
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
    Should Contain    ${POSTMAN_PATCH_RESPONSE}    200 OK
    [Tags]    Regression_Tests    Unrefined_And_Created_In_A_Hurry

POSTMAN NEWMAN COLLECTION EXAMPLE PART ONE : Send a GET request to jsonplaceholder.typicode.com/posts/1 and check the response.
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

POSTMAN NEWMAN COLLECTION EXAMPLE PART ONE : Send a DELETE request to jsonplaceholder.typicode.com/posts/1 and check the response.
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

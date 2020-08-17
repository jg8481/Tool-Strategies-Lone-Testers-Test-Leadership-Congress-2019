*** Settings ***

Documentation     Part Two of the cURL examples has been enhanced by using the Shared-Keywords-And-Listeners.robot resource file to add randomly generated malformed data to a test through the "Create Random Malformed Test Data With Radamsa" keyword.
...               This keyword turns the cURL examples into an API fuzz testing tool that can run in serial or in parallel.

Library           Process

Resource          ${EXECDIR}//Shared-Resources//Shared-Keywords-And-Listeners.robot

Suite Teardown    Remove File    ${PATH}//testlog-check-response-after-using-radamsa-on-the-json1.txt

*** Variables ***
${PATH}    ${EXECDIR}//Shared-Resources

*** Test Cases ***

CURL EXAMPLE PART TWO - ROBOT FILE ONE : Send a PATCH request to "userId" for jsonplaceholder.typicode.com/posts/1 using malformed test data and check the response.
    Create Random Malformed Test Data With Radamsa    ¯\_(ツ)_/¯
    Run    MALFORMED_TEST_DATA=$(cat /rfw/Shared-Resources/malformed-test-data.txt) && curl -i -X PATCH -H 'Content-Type: application/json' http://${BASE_URL}/posts/1 -d '{"userId": '"$MALFORMED_TEST_DATA"'}' 2>/dev/null > /rfw/Shared-Resources/testlog-check-response-after-using-radamsa-on-the-json1.txt
    ${CURL_ROBOT_FILE_ONE_PATCH_RESPONSE}=   	Get File    ${PATH}//testlog-check-response-after-using-radamsa-on-the-json1.txt
    Log    ${CURL_ROBOT_FILE_ONE_PATCH_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${CURL_ROBOT_FILE_ONE_PATCH_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Not Contain    ${CURL_ROBOT_FILE_ONE_PATCH_RESPONSE}    200 OK    ignore_case=True
    [Tags]    Regression_Tests    Unrefined_And_Created_In_A_Hurry

*** Settings ***

Documentation     This test combines Robot Framework strategies, keywords, test data generators and listeners found in all of the other examples in Part Two with Graphwalker.
...               The approach used here to combine Robot Framework with Graphwalker is based on this article... https://ixn.intersection.com/continuous-learning-to-guide-testing-decisions-a69ee295c1fd

Library           OperatingSystem
Library           Collections
Library           Process
Library           RequestsLibrary

Resource          ${EXECDIR}//Shared-Resources//Shared-Keywords-And-Listeners.robot

Test Teardown     Trigger Only After Failure
Suite Teardown    Remove File    ${PATH}//testlog-check-response-after-using-radamsa-on-the-json*.txt

*** Variables ***
${PATH}    ${EXECDIR}//Shared-Resources

*** Test Cases ***

GRAPHWALKER START : This helps avoid skipping the first actual Graphwalker Edge of the Graphwalker path file.
    Log To Console    This runs first.
    Log    This runs first.
    [Tags]    start

GRAPHWALKER EDGE - ACTION : send_patch_to_jsonplaceholder_with_valid_data
    [Documentation]    A Graphwalker edge expresses an action performed on the system-under-test, and a Graphwalker vertex expresses a state of the SUT which should be tested... http://graphwalker.github.io/Model_design/
    ${HEADERS}=       Create Dictionary    Content-Type    application/json
    Create Session    jsonplaceholder    http://${BASE_URL}    headers=${HEADERS}
    ${GRAPHWALKER_VALID_PATCH_RESPONSE}=    Patch Request    jsonplaceholder    /posts/1    data={"title":"Testing with Robot Framework."}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${GRAPHWALKER_VALID_PATCH_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${GRAPHWALKER_VALID_PATCH_RESPONSE.json()}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${GRAPHWALKER_VALID_PATCH_RESPONSE.status_code}    200
    Dictionary Should Contain Value    ${GRAPHWALKER_VALID_PATCH_RESPONSE.json()}    Testing with Robot Framework.
    [Tags]    send_patch_to_jsonplaceholder_with_valid_data    Graphwalker_Edge_Model-Based_Tests


GRAPHWALKER EDGE - ACTION : send_post_to_jsonplaceholder
    [Documentation]    A Graphwalker edge expresses an action performed on the system-under-test, and a Graphwalker vertex expresses a state of the SUT which should be tested... http://graphwalker.github.io/Model_design/
    ${HEADERS}=       Create Dictionary    Content-Type    application/json
    Create Session    jsonplaceholder    http://${BASE_URL}    headers=${HEADERS}
    ${GRAPHWALKER_POST_RESPONSE}=    Post Request    jsonplaceholder    /posts
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${GRAPHWALKER_POST_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${GRAPHWALKER_POST_RESPONSE.json()}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${GRAPHWALKER_POST_RESPONSE.status_code}    201
    Dictionary Should Contain Key    ${GRAPHWALKER_POST_RESPONSE.json()}    id
    ${POST_RESPONSE_VALUES}=     Get Dictionary Values    ${GRAPHWALKER_POST_RESPONSE.json()}
    Should Be Equal As Strings    ${POST_RESPONSE_VALUES}    [101]
    [Tags]    send_post_to_jsonplaceholder    Graphwalker_Edge_Model-Based_Tests

GRAPHWALKER EDGE - ACTION : send_put_to_jsonplaceholder
    [Documentation]    A Graphwalker edge expresses an action performed on the system-under-test, and a Graphwalker vertex expresses a state of the SUT which should be tested... http://graphwalker.github.io/Model_design/
    ${HEADERS}=       Create Dictionary    Content-Type    application/json
    Create Session    jsonplaceholder    http://${BASE_URL}    headers=${HEADERS}
    ${GRAPHWALKER_PUT_RESPONSE}=    Put Request    jsonplaceholder    /posts/1
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${GRAPHWALKER_PUT_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${GRAPHWALKER_PUT_RESPONSE.json()}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${GRAPHWALKER_PUT_RESPONSE.status_code}    200
    Dictionary Should Contain Key    ${GRAPHWALKER_PUT_RESPONSE.json()}    id
    ${PUT_RESPONSE_VALUES}=     Get Dictionary Values    ${GRAPHWALKER_PUT_RESPONSE.json()}
    Should Be Equal As Strings    ${PUT_RESPONSE_VALUES}    [1]
    [Tags]    send_put_to_jsonplaceholder    Graphwalker_Edge_Model-Based_Tests

GRAPHWALKER EDGE - ACTION : send_delete_to_jsonplaceholder
    [Documentation]    A Graphwalker edge expresses an action performed on the system-under-test, and a Graphwalker vertex expresses a state of the SUT which should be tested... http://graphwalker.github.io/Model_design/
    ${HEADERS}=       Create Dictionary    Content-Type    application/json
    Create Session    jsonplaceholder    http://${BASE_URL}    headers=${HEADERS}
    ${GRAPHWALKER_DELETE_RESPONSE}=    Delete Request    jsonplaceholder    /posts/1
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${GRAPHWALKER_DELETE_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${GRAPHWALKER_DELETE_RESPONSE.status_code}    200
    Should Be Empty    ${GRAPHWALKER_DELETE_RESPONSE.json()}
    [Tags]    send_delete_to_jsonplaceholder    Graphwalker_Edge_Model-Based_Tests


GRAPHWALKER EDGE - ACTION : send_patch_to_jsonplaceholder_with_invalid_data
    [Documentation]    A Graphwalker edge expresses an action performed on the system-under-test, and a Graphwalker vertex expresses a state of the SUT which should be tested... http://graphwalker.github.io/Model_design/
    Create Random Malformed Test Data With Radamsa    ¯\_(ツ)_/¯
    Run    MALFORMED_TEST_DATA=$(cat /rfw/Shared-Resources/malformed-test-data.txt) && curl -i -X PATCH -H 'Content-Type: application/json' http://${BASE_URL}/posts/1 -d '{"userId": '"$MALFORMED_TEST_DATA"'}' 2>/dev/null > /rfw/Shared-Resources/testlog-check-response-after-using-radamsa-on-the-json1.txt
    ${GRAPHWALKER_INVALID_PATCH_RESPONSE}=   	Get File    ${PATH}//testlog-check-response-after-using-radamsa-on-the-json1.txt
    Log    ${GRAPHWALKER_INVALID_PATCH_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${GRAPHWALKER_INVALID_PATCH_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Not Contain    ${GRAPHWALKER_INVALID_PATCH_RESPONSE}    200 OK    ignore_case=True
    [Tags]    send_patch_to_jsonplaceholder_with_invalid_data    Graphwalker_Edge_Model-Based_Tests


GRAPHWALKER EDGE - ACTION : send_patch_to_jsonplaceholder_with_valid_data_on_a_slow_connection
    [Documentation]    A Graphwalker edge expresses an action performed on the system-under-test, and a Graphwalker vertex expresses a state of the SUT which should be tested... http://graphwalker.github.io/Model_design/
    ${PROXIES}=     Create Dictionary     http=http://127.0.0.1:5000    https=http://127.0.0.1:5000
    ${HEADERS}=       Create Dictionary    Content-Type    application/json
    Create Session    jsonplaceholder    http://${BASE_URL}    headers=${HEADERS}    proxies=${PROXIES}
    ${GRAPHWALKER_VALID_SLOW_PATCH_RESPONSE}=    Patch Request    jsonplaceholder    /posts/1    data={"title":"Testing with Robot Framework."}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${GRAPHWALKER_VALID_SLOW_PATCH_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${GRAPHWALKER_VALID_SLOW_PATCH_RESPONSE.json()}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${GRAPHWALKER_VALID_SLOW_PATCH_RESPONSE.status_code}    200
    Dictionary Should Contain Value    ${GRAPHWALKER_VALID_SLOW_PATCH_RESPONSE.json()}    Testing with Robot Framework.
    [Tags]    send_patch_to_jsonplaceholder_with_valid_data_on_a_slow_connection    Graphwalker_Edge_Model-Based_Tests


GRAPHWALKER EDGE - ACTION : send_patch_to_jsonplaceholder_with_invalid_data_on_a_slow_connection
    [Documentation]    A Graphwalker edge expresses an action performed on the system-under-test, and a Graphwalker vertex expresses a state of the SUT which should be tested... http://graphwalker.github.io/Model_design/
    Create Various Random Test Data With The String Library
    ${PROXIES}=     Create Dictionary     http=http://127.0.0.1:5000    https=http://127.0.0.1:5000
    ${HEADERS}=       Create Dictionary    Content-Type    application/json
    Create Session    jsonplaceholder    http://${BASE_URL}    headers=${HEADERS}    proxies=${PROXIES}
    ${GRAPHWALKER_INVALID_SLOW_PATCH_RESPONSE}=    Patch Request    jsonplaceholder    /posts/1    data={"userId": ${COMPLETELY_RANDOM_STRING}}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${GRAPHWALKER_INVALID_SLOW_PATCH_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Not Be Equal As Strings    ${GRAPHWALKER_INVALID_SLOW_PATCH_RESPONSE.status_code}    200
    [Tags]    send_patch_to_jsonplaceholder_with_invalid_data_on_a_slow_connection    Graphwalker_Edge_Model-Based_Tests


GRAPHWALKER EDGE - ACTION : send_delete_to_jsonplaceholder_on_a_slow_connection
    [Documentation]    A Graphwalker edge expresses an action performed on the system-under-test, and a Graphwalker vertex expresses a state of the SUT which should be tested... http://graphwalker.github.io/Model_design/
    ${PROXIES}=     Create Dictionary     http=http://127.0.0.1:5000    https=http://127.0.0.1:5000
    ${HEADERS}=       Create Dictionary    Content-Type    application/json
    Create Session    jsonplaceholder    http://${BASE_URL}    headers=${HEADERS}    proxies=${PROXIES}
    ${GRAPHWALKER_SLOW_DELETE_RESPONSE}=    Delete Request    jsonplaceholder    /posts/1
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${GRAPHWALKER_SLOW_DELETE_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${GRAPHWALKER_SLOW_DELETE_RESPONSE.status_code}    200
    Should Be Empty    ${GRAPHWALKER_SLOW_DELETE_RESPONSE.json()}
    [Tags]    send_delete_to_jsonplaceholder_on_a_slow_connection    Graphwalker_Edge_Model-Based_Tests


GRAPHWALKER EDGE - ACTION : send_post_to_jsonplaceholder_on_a_slow_connection
    [Documentation]    A Graphwalker edge expresses an action performed on the system-under-test, and a Graphwalker vertex expresses a state of the SUT which should be tested... http://graphwalker.github.io/Model_design/
    ${PROXIES}=     Create Dictionary     http=http://127.0.0.1:5000    https=http://127.0.0.1:5000
    ${HEADERS}=       Create Dictionary    Content-Type    application/json
    Create Session    jsonplaceholder    http://${BASE_URL}    headers=${HEADERS}    proxies=${PROXIES}
    ${GRAPHWALKER_SLOW_POST_RESPONSE}=    Post Request    jsonplaceholder    /posts
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${GRAPHWALKER_SLOW_POST_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${GRAPHWALKER_SLOW_POST_RESPONSE.json()}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${GRAPHWALKER_SLOW_POST_RESPONSE.status_code}    201
    ## This will make the test fail. We are doing this to trigger team notification keyword.
    Dictionary Should Not Contain Key    ${GRAPHWALKER_SLOW_POST_RESPONSE.json()}    id
    ${POST_RESPONSE_VALUES}=     Get Dictionary Values    ${GRAPHWALKER_SLOW_POST_RESPONSE.json()}
    Should Be Equal As Strings    ${POST_RESPONSE_VALUES}    [101]
    [Tags]    send_post_to_jsonplaceholder_on_a_slow_connection    Graphwalker_Edge_Model-Based_Tests


GRAPHWALKER VERTEX - TEST ASSERTION : send_get_to_jsonplaceholder_after_sending_invalid_data_on_a_slow_connection
    [Documentation]    A Graphwalker edge expresses an action performed on the system-under-test, and a Graphwalker vertex expresses a state of the SUT which should be tested... http://graphwalker.github.io/Model_design/
    ${PROXIES}=     Create Dictionary     http=http://127.0.0.1:5000    https=http://127.0.0.1:5000
    ${HEADERS}=       Create Dictionary    Content-Type    application/json
    Create Session    jsonplaceholder    http://${BASE_URL}    headers=${HEADERS}    proxies=${PROXIES}
    ${GRAPHWALKER_SLOW_GET_RESPONSE}=    Get Request    jsonplaceholder    /posts/1
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${GRAPHWALKER_SLOW_GET_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${GRAPHWALKER_SLOW_GET_RESPONSE.json()}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${GRAPHWALKER_SLOW_GET_RESPONSE.status_code}    200
    Dictionary Should Contain Value    ${GRAPHWALKER_SLOW_GET_RESPONSE.json()}    quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto
    Dictionary Should Not Contain Value    ${GRAPHWALKER_SLOW_GET_RESPONSE.json()}    Testing with Robot Framework.
    [Tags]    send_get_to_jsonplaceholder_after_sending_invalid_data_on_a_slow_connection    Graphwalker_Vertex_Model-Based_Tests


GRAPHWALKER VERTEX - TEST ASSERTION : send_get_to_jsonplaceholder_after_sending_valid_data_on_a_slow_connection
    [Documentation]    A Graphwalker edge expresses an action performed on the system-under-test, and a Graphwalker vertex expresses a state of the SUT which should be tested... http://graphwalker.github.io/Model_design/
    ${PROXIES}=     Create Dictionary     http=http://127.0.0.1:5000    https=http://127.0.0.1:5000
    ${HEADERS}=       Create Dictionary    Content-Type    application/json
    Create Session    jsonplaceholder    http://${BASE_URL}    headers=${HEADERS}    proxies=${PROXIES}
    ${GRAPHWALKER_SLOW_GET_RESPONSE}=    Get Request    jsonplaceholder    /posts/1
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${GRAPHWALKER_SLOW_GET_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${GRAPHWALKER_SLOW_GET_RESPONSE.json()}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${GRAPHWALKER_SLOW_GET_RESPONSE.status_code}    200
    Dictionary Should Contain Value    ${GRAPHWALKER_SLOW_GET_RESPONSE.json()}    quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto
    Dictionary Should Not Contain Value    ${GRAPHWALKER_SLOW_GET_RESPONSE.json()}    Testing with Robot Framework.
    [Tags]    send_get_to_jsonplaceholder_after_sending_valid_data_on_a_slow_connection    Graphwalker_Vertex_Model-Based_Tests


GRAPHWALKER VERTEX - TEST ASSERTION : send_get_to_jsonplaceholder_after_sending_invalid_data
    [Documentation]    A Graphwalker edge expresses an action performed on the system-under-test, and a Graphwalker vertex expresses a state of the SUT which should be tested... http://graphwalker.github.io/Model_design/
    ${HEADERS}=       Create Dictionary    Content-Type    application/json
    Create Session    jsonplaceholder    http://${BASE_URL}    headers=${HEADERS}
    ${GRAPHWALKER_GET_RESPONSE}=    Get Request    jsonplaceholder    /posts/1
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${GRAPHWALKER_GET_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${GRAPHWALKER_GET_RESPONSE.json()}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${GRAPHWALKER_GET_RESPONSE.status_code}    200
    Dictionary Should Contain Value    ${GRAPHWALKER_GET_RESPONSE.json()}    quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto
    Dictionary Should Not Contain Value    ${GRAPHWALKER_GET_RESPONSE.json()}    Testing with Robot Framework.
    [Tags]    send_get_to_jsonplaceholder_after_sending_invalid_data    Graphwalker_Vertex_Model-Based_Tests


GRAPHWALKER VERTEX - TEST ASSERTION : send_get_to_jsonplaceholder_after_sending_valid_data
    [Documentation]    A Graphwalker edge expresses an action performed on the system-under-test, and a Graphwalker vertex expresses a state of the SUT which should be tested... http://graphwalker.github.io/Model_design/
    ${HEADERS}=       Create Dictionary    Content-Type    application/json
    Create Session    jsonplaceholder    http://${BASE_URL}    headers=${HEADERS}
    ${GRAPHWALKER_GET_RESPONSE}=    Get Request    jsonplaceholder    /posts/1
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${GRAPHWALKER_GET_RESPONSE}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Log To Console    ${GRAPHWALKER_GET_RESPONSE.json()}
    Log To Console    .
    Log To Console    .
    Log To Console    .
    Should Be Equal As Strings    ${GRAPHWALKER_GET_RESPONSE.status_code}    200
    Dictionary Should Contain Value    ${GRAPHWALKER_GET_RESPONSE.json()}    quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto
    Dictionary Should Not Contain Value    ${GRAPHWALKER_GET_RESPONSE.json()}    Testing with Robot Framework.
    [Tags]    send_get_to_jsonplaceholder_after_sending_valid_data    Graphwalker_Vertex_Model-Based_Tests


*** Keywords ***

Trigger Only After Failure
    Run Keyword If Test Failed     Failure Detected Notify Team

Failure Detected Notify Team
    Send Short Message Through Slack And Email   ${GRAPHWALKER} Graphwalker step   ${TEST_ENVIRONMENT}

*** Settings ***

Documentation    In a hypothetical scenario, where you are split between 3 or more frequently changing projects. Maybe you were able to convince your team leaders and developers
...              to provide you with some help building out the Robot Framework regression tests. The following assumes that the team member helping you is most likely a developer.
...              The developer helping you is comfortable with contributing to a test that uses a few keywords from the standard Robot Framework BuiltIn Library, and the rest is
...              handled by a user-created library. In this case the library is written in Python...

Library          Collections
Library          ${EXECDIR}//Tests//Workshop-Part-One//Resources//DockerExample.py

*** Test Cases ***

USER-CREATED PYTHON LIBRARY EXAMPLE PART ONE - ROBOT FILE ONE : Send a POST request to jsonplaceholder.typicode.com/posts and check the response.
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

USER-CREATED PYTHON LIBRARY EXAMPLE PART ONE - ROBOT FILE ONE : Send a PATCH request to "title" for jsonplaceholder.typicode.com/posts/1 and check the response.
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

USER-CREATED PYTHON LIBRARY EXAMPLE PART ONE - ROBOT FILE ONE : Send a GET request to jsonplaceholder.typicode.com/posts/1 and check the response.
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
    Should Be Equal As Strings    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_GET_RESPONSE.status_code}    200
    Dictionary Should Contain Value    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_GET_RESPONSE.json()}    quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto
    Dictionary Should Not Contain Value    ${PYTHON_LIBRARY_ROBOT_FILE_ONE_GET_RESPONSE.json()}    Testing with Robot Framework.
    [Tags]    Regression_Tests    Slightly_Refined_And_Room_For_Enhancements

USER-CREATED PYTHON LIBRARY EXAMPLE PART ONE - ROBOT FILE ONE : Send a DELETE request to jsonplaceholder.typicode.com/posts/1 and check the response.
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

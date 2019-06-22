*** Settings ***

Documentation    This Robot Framework resource file has shared keywords and listeners that can be re-used and shared across all of the enhanced Docker examples in Part Two.
...              The examples below in this resource file can be used to enhance existing Robot files by adding notification capabilities, test runtime execution/speed metrics,
...              automatic failure of tests that take too long to run, various options for automatically generating randomized or malformed test data etc. The possibilities are too much to cover here.
...              More information about Robot Framework listeners can be found here...http://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#setting-listeners

Library                       String
Library                       OperatingSystem
Library                       Process
Library                       ${EXECDIR}//Shared-Resources//TestFailureEmailNotification.py
Library                       ${EXECDIR}//Shared-Resources//DurationTrackingListener.py
Library                       ${EXECDIR}//Shared-Resources//TimeTrackingListener.py

*** Variable ***
${PATH}    ${EXECDIR}//Shared-Resources

*** Keywords ***

Send Short Message Through Slack And Email
    ## There are various solutions out there for sending Slack messages through its API. Here are some examples.
    ##
    ## robot-framework-slack-notifier is a cross-platform solution...
    ## https://github.com/Ville-/robot-framework-slack-notifier
    ##
    ## slacktee is a very simple to use Slack client that you can use to pipe text into Slack channels...
    ## https://github.com/coursehero/slacktee
    ##
    ## The folowing keyword will demonstrate slacktee...
    [Arguments]    ${TEST_NAME}    ${TEST_ENVIRONMENT}
    Run Process    echo "The ${TEST_NAME} failed in the ${TEST_ENVIRONMENT} environment." | slacktee.sh -i :nerd_face: --plain-text --config /rfw/Shared-Resources/.slacktee    shell=True    timeout=20s    on_timeout=continue
    Send Email Notification    ## You might want to include these in the email message -> ${TEST_NAME}    ${TEST_ENVIRONMENT}

Create Random Malformed Test Data With Radamsa
    ## Radamsa is a general purpose fuzzer. It has a large amount of possible uses in software testing, pentesting, and possibly other things...
    ##
    ## https://gitlab.com/akihe/radamsa
    ##
    ## Here are some examples of Radamsa being used in other projects...
    ##
    ## https://github.com/Darkkey/erlamsa
    ##
    ## https://github.com/CIFASIS/QuickFuzz
    ##
    ## FYI - Depending on the malformed data that comes from Radamsa, you might get "UnicodeDecodeError: 'utf-8' codec can't decode byte 0xf3 in position 1: invalid continuation byte" if you try to use the data with Set Suite Variable.
    [Arguments]    ${TEST_DATA}
    Run Process    echo "${TEST_DATA}" | radamsa -n 2 > ./malformed-test-data.txt    shell=True    timeout=20s    on_timeout=continue    cwd=${PATH}

Create Various Random Test Data With The String Library
    ## The built in String Library can be used to create randomized test data...
    ##
    ## http://robotframework.org/robotframework/latest/libraries/String.html#Generate%20Random%20String
    ${COMPLETELY_RANDOM_STRING} =    Generate Random String    30
    ${LOWERCASE_LETTERS_RANDOM_STRING} =    Generate Random String    18    [LOWER]
    ${LOWERCASE_UPPERCASE_LETTERS_RANDOM_STRING} =    Generate Random String    20    [LETTERS]
    ${LETTERS_WITH_NUMBERS_RANDOM_STRING} =    Generate Random String    10	  aaaaaaaabbbbbb[NUMBERS]
    Set Suite Variable    ${COMPLETELY_RANDOM_STRING}
    Set Suite Variable    ${LOWER_CASE_LETTERS_RANDOM_STRING}
    Set Suite Variable    ${LOWERCASE_UPPERCASE_LETTERS_RANDOM_STRING}
    Set Suite Variable    ${LETTERS_WITH_NUMBERS_RANDOM_STRING}
    Log To Console    -------
    Log To Console    COMPLETELY RANDOM STRING 30 CHARACTERS LONG...
    Log To Console    ${COMPLETELY_RANDOM_STRING}
    Log To Console    -------
    Log To Console    LOWERCASE LETTERS RANDOM STRING 18 CHARACTERS LONG...
    Log To Console    ${LOWERCASE_LETTERS_RANDOM_STRING}
    Log To Console    -------
    Log To Console    LOWERCASE AND UPPERCASE LETTERS RANDOM STRING 20 CHARACTERS LONG...
    Log To Console    ${LOWERCASE_UPPERCASE_LETTERS_RANDOM_STRING}
    Log To Console    -------
    Log To Console    RANDOM NUMBERS APPENDED TO LETTERS...
    Log To Console    ${LETTERS_WITH_NUMBERS_RANDOM_STRING}
    Log To Console    -------
    Log    ${COMPLETELY_RANDOM_STRING}
    Log    ${LOWERCASE_LETTERS_RANDOM_STRING}
    Log    ${LOWERCASE_UPPERCASE_LETTERS_RANDOM_STRING}
    Log    ${LETTERS_WITH_NUMBERS_RANDOM_STRING}

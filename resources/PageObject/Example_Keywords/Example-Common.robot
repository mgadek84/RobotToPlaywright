*** Settings ***
Documentation    Example general API calls
Library          base64
Library          JSONLibrary
Library          RequestsLibrary
Library          Collections
Library          OperatingSystem
Library          String
Library          BuiltIn
Library          DateTime
Resource         ../../../config.properties/config.properties.robot
Variables        Example-Config.yaml

*** Variables ***
${json_variable}                                    jsonplaceholder
${bearer_token}                                     bearerplaceholder
${x-request-id}                                     xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
${MAX_RETRIES}                                      10
${EMPTY_PARAMETER}
${PAGE_MIN}                                         1
${PAGE_MAX}                                         999999999999999999999999
${PAGESIZE_MIN}                                     1
${PAGESIZE_MAX}                                     999999999999999999999999
${EMAIL_ROBOT_TESTS}                                exampleRobotFramework@test.com
${DATE_INCORRECT}                                   9999-99-99


*** Keywords ***
Create Session by URL
    [Arguments]    ${URL}
    ${header}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${bearer_token}
    Create Session    ${json_variable}    ${URL}    headers=${header}    verify=True

Create Unauthorized Session by URL
    [Arguments]    ${URL}
    ${header}=    Create Dictionary    Content-Type=application/json
    Create Session    ${json_variable}    ${URL}    headers=${header}    verify=True

Example Example Get Bearer token
    [Documentation]  Request Example bearer token from /login/local/auth
    Set Log Level    NONE
    ${header}=    Create Dictionary    Content-Type=application/json    x-request-id=${x-request-id}
    ${decoded_password}=    Evaluate    base64.b64decode('${EXAMPLE_PASSWORD}').decode('utf-8')
    Set To Dictionary    ${example_login}    password=${decoded_password}
    ${response}=    Post On Session    ${json_variable}    /login/local/auth    json=${example_login}    headers=${header}
    Should Be Equal As Strings    ${response.status_code}    200
    ${response_json}=    Convert String To JSON    ${response.content}
    ${bearer_token}=    Get From Dictionary    ${response_json}  token
    Set Suite Variable    ${bearer_token}
    Set Log Level    INFO

Should Not Be Empty Number
    [Documentation]   Use to assert if response is an integer.
    [Arguments]    ${number}
    Should Not Be Equal    ${number}    ${None}
    Should Be True    ${number} >= 0

Number Should Be Equal Zero
    [Documentation]   Use to assert if response is an integer.
    [Arguments]    ${number}
    Should Not Be Equal    ${number}    ${None}
    Should Be True    ${number} == 0

Number Should be Equal One
    [Documentation]    Assert if response is an integer and equal one
    [Arguments]   ${number}
    Should Not Be Equal  ${number}      ${None}
    should be true      ${number} == 1

Number Generator
    [Documentation]  Genrating random number
    ${n_sub}=    Evaluate    str(random.randint(1000, 9999))
    ${output_result}=    Catenate    xxxxxxxx-${n_sub}-xxxx-xxxx-xxxxxxxxxxxx
    Set Global Variable    ${output_result}

Generate Random Number
    [Documentation]  Generating a random number
    ${random_number}=    Evaluate    str(random.randint(1, 999999))    modules=random
    RETURN        ${random_number}

Generate Random Number 1000-9999
    [Documentation]  Generating a random number
    ${random_number_1000_9999}=    Evaluate    str(random.randint(1000, 9999))    modules=random
    RETURN        ${random_number_1000_9999}

Current Date
    [Documentation]  Generating current date down to seconds
    ${current_date_and_time}=    Get Current Date     result_format=%d %b %Y %I:%M %p
    RETURN        ${current_date_and_time}

Current Date y m d
    [Documentation]  Generating current date Year, Month, Day
    ${current_date_and_time}=    Get Current Date     result_format=%Y-%m-%d 
    RETURN        ${current_date_and_time}

Example Deauth
    Create Session by URL    ${EXAMPLE_URL}
    Example Get Bearer token
    Sleep  500ms
    [Documentation]  Destroys the current authenticated session.
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${response}=  GET On Session  ${json_variable}  /login/local/deauth
    ...  headers=${header}   expected_status=200
    


*** Settings ***
Documentation    Session handling and shared response checks for the reqres.in API.
Library          RequestsLibrary
Library          Collections
Resource         ../../../../config.properties/config.properties.robot
Variables        ../../TestData/Reqres_TestData.py


*** Variables ***
${REQRES_SESSION}       reqres
# Transient statuses retried for idempotent requests (GET, PUT, DELETE); POST is never retried.
${RETRY_STATUSES}       ${{[429, 502, 503, 504]}}


*** Keywords ***
Create Reqres Session
    [Documentation]    Opens a session to ``REQRES_BASE_URL`` that sends ``x-api-key`` with every request.
    [Arguments]    ${alias}=${REQRES_SESSION}    ${api_key}=${REQRES_API_KEY}
    ${headers}=    Create Dictionary    Accept=application/json    x-api-key=${api_key}
    Create Session    ${alias}    ${REQRES_BASE_URL}    headers=${headers}
    ...    timeout=${REQRES_TIMEOUT}    verify=${True}
    ...    max_retries=3    backoff_factor=1    retry_status_list=${RETRY_STATUSES}

Request Should Return Status
    [Documentation]    Sends a body-less ``method`` request to ``path`` and checks only the HTTP status code.
    [Arguments]    ${method}    ${path}    ${expected_status}    ${session}=${REQRES_SESSION}
    ${response}=    Run Keyword    ${method} On Session    ${session}    ${path}    expected_status=any
    Status Should Be    ${expected_status}    ${response}

Response Field Should Be
    [Arguments]    ${response}    ${field}    ${expected_value}
    ${body}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${body}    ${field}
    Should Be Equal As Strings    ${body}[${field}]    ${expected_value}

Response Should Contain Values
    [Documentation]    Checks that every key/value pair of ``expected`` is present in the JSON body.
    [Arguments]    ${response}    ${expected}
    Dictionary Should Contain Sub Dictionary    ${response.json()}    ${expected}

Response Timestamp Should Be Valid
    [Arguments]    ${response}    ${field}
    ${body}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${body}    ${field}
    Should Match Regexp    ${body}[${field}]    ${ISO_TIMESTAMP_PATTERN}

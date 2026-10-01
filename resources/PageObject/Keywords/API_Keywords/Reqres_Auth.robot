*** Settings ***
Documentation    Keywords for the reqres.in ``/login`` endpoint.
Resource         Reqres_Common.robot


*** Keywords ***
Log In To Reqres
    [Documentation]    Posts ``credentials`` to ``/login`` and returns the response.
    [Arguments]    ${credentials}    ${expected_status}=200
    ${response}=    POST On Session    ${REQRES_SESSION}    /login    json=${credentials}
    ...    expected_status=${expected_status}
    RETURN    ${response}

Login Response Should Contain Token
    [Arguments]    ${response}
    ${body}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${body}    token
    Should Not Be Empty    ${body}[token]

Login Response Should Contain Error
    [Arguments]    ${response}    ${expected_error}
    Response Field Should Be    ${response}    error    ${expected_error}
    Dictionary Should Not Contain Key    ${response.json()}    token

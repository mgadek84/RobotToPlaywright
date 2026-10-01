*** Settings ***
Documentation    Keywords for the reqres.in ``/users`` endpoints.
Resource         Reqres_Common.robot


*** Keywords ***
Get Users Page
    [Arguments]    ${page}    ${expected_status}=200
    ${params}=    Create Dictionary    page=${page}
    ${response}=    GET On Session    ${REQRES_SESSION}    /users    params=${params}
    ...    expected_status=${expected_status}
    RETURN    ${response}

Get User
    [Arguments]    ${user_id}    ${expected_status}=200
    ${response}=    GET On Session    ${REQRES_SESSION}    /users/${user_id}
    ...    expected_status=${expected_status}
    RETURN    ${response}

Create User
    [Arguments]    ${user}    ${expected_status}=201
    ${response}=    POST On Session    ${REQRES_SESSION}    /users    json=${user}
    ...    expected_status=${expected_status}
    RETURN    ${response}

Update User
    [Arguments]    ${user_id}    ${user}    ${expected_status}=200
    ${response}=    PUT On Session    ${REQRES_SESSION}    /users/${user_id}    json=${user}
    ...    expected_status=${expected_status}
    RETURN    ${response}

Delete User
    [Arguments]    ${user_id}    ${expected_status}=204
    ${response}=    DELETE On Session    ${REQRES_SESSION}    /users/${user_id}
    ...    expected_status=${expected_status}
    RETURN    ${response}

Users Page Should Be
    [Documentation]    Checks the pagination metadata and the user IDs returned for ``page``.
    [Arguments]    ${response}    ${page}    ${expected_ids}
    ${body}=    Set Variable    ${response.json()}
    Should Be Equal As Integers    ${body}[page]    ${page}
    Should Be Equal As Integers    ${body}[per_page]    ${USERS_PER_PAGE}
    Should Be Equal As Integers    ${body}[total]    ${USERS_TOTAL}
    Should Be Equal As Integers    ${body}[total_pages]    ${USERS_TOTAL_PAGES}
    ${ids}=    Evaluate    [user["id"] for user in $body["data"]]
    Lists Should Be Equal    ${ids}    ${expected_ids}

User Response Should Match
    [Arguments]    ${response}    ${expected_user}
    Dictionary Should Contain Sub Dictionary    ${response.json()}[data]    ${expected_user}

Created User Response Should Match
    [Arguments]    ${response}    ${expected_user}
    Response Should Contain Values    ${response}    ${expected_user}
    Dictionary Should Contain Key    ${response.json()}    id
    Should Not Be Equal As Strings    ${response.json()}[id]    ${EMPTY}
    Response Timestamp Should Be Valid    ${response}    createdAt

Updated User Response Should Match
    [Arguments]    ${response}    ${expected_user}
    Response Should Contain Values    ${response}    ${expected_user}
    Response Timestamp Should Be Valid    ${response}    updatedAt

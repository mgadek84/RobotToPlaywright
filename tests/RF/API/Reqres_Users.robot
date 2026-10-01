*** Settings ***
Documentation     reqres.in users: pagination, single user lookup, create, update, delete and status codes.
Resource          ../../../resources/PageObject/Keywords/API_Keywords/Reqres_Users.robot
Suite Setup       Create Reqres Session
Suite Teardown    Delete All Sessions
Test Timeout      1 minute
Test Tags         api    users


*** Test Cases ***
List Users Returns First Page
    [Tags]    smoke
    ${response}=    Get Users Page    1
    Users Page Should Be    ${response}    1    ${FIRST_PAGE_USER_IDS}

List Users Returns Second Page
    ${response}=    Get Users Page    2
    Users Page Should Be    ${response}    2    ${SECOND_PAGE_USER_IDS}

List Users Beyond Last Page Returns No Users
    ${response}=    Get Users Page    3
    Users Page Should Be    ${response}    3    ${NO_USER_IDS}

Get Single User Returns User Details
    [Tags]    smoke
    ${response}=    Get User    ${EXISTING_USER}[id]
    User Response Should Match    ${response}    ${EXISTING_USER}

Get Unknown User Returns 404
    [Tags]    negative
    ${response}=    Get User    ${UNKNOWN_USER_ID}    expected_status=404
    Should Be Empty    ${response.json()}

Create User Returns 201 With Id
    [Tags]    smoke
    ${response}=    Create User    ${NEW_USER}
    Created User Response Should Match    ${response}    ${NEW_USER}

Update User Returns Updated Fields
    ${response}=    Update User    ${EXISTING_USER}[id]    ${UPDATED_USER}
    Updated User Response Should Match    ${response}    ${UPDATED_USER}

Delete User Returns 204 With Empty Body
    ${response}=    Delete User    ${EXISTING_USER}[id]
    Should Be Empty    ${response.content}

Endpoints Return Expected Status Codes
    [Tags]    status-codes
    [Template]    Request Should Return Status
    GET       /users?page=1                     200
    GET       /users/${EXISTING_USER}[id]       200
    GET       /users/${UNKNOWN_USER_ID}         404
    GET       /unknown/2                        200
    GET       /unknown/${UNKNOWN_USER_ID}       404
    DELETE    /users/${EXISTING_USER}[id]       204

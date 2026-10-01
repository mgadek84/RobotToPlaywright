*** Settings ***
Documentation     reqres.in authentication: successful login, rejected logins and API key checks.
Resource          ../../../resources/PageObject/Keywords/API_Keywords/Reqres_Auth.robot
Suite Setup       Create Reqres Session
Suite Teardown    Delete All Sessions
Test Timeout      1 minute
Test Tags         api    auth


*** Variables ***
${INVALID_KEY_SESSION}    reqres_invalid_key


*** Test Cases ***
Login With Valid Credentials Returns Token
    [Tags]    smoke
    ${response}=    Log In To Reqres    ${VALID_LOGIN}
    Login Response Should Contain Token    ${response}

Login Without Password Is Rejected
    [Tags]    negative
    ${response}=    Log In To Reqres    ${LOGIN_WITHOUT_PASSWORD}    expected_status=400
    Login Response Should Contain Error    ${response}    ${MISSING_PASSWORD_ERROR}

Login With Unknown User Is Rejected
    [Tags]    negative
    ${response}=    Log In To Reqres    ${LOGIN_UNKNOWN_USER}    expected_status=400
    Login Response Should Contain Error    ${response}    ${UNKNOWN_USER_ERROR}

Request With Invalid API Key Is Rejected
    [Tags]    negative
    Create Reqres Session    alias=${INVALID_KEY_SESSION}    api_key=${INVALID_API_KEY}
    Request Should Return Status    GET    /users/${EXISTING_USER}[id]    403    session=${INVALID_KEY_SESSION}

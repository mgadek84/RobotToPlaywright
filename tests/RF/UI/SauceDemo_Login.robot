*** Settings ***
Documentation     saucedemo.com login and logout.
Resource          ../../../resources/PageObject/Keywords/UI_Keywords/SauceDemo_LoginPage.robot
Resource          ../../../resources/PageObject/Keywords/UI_Keywords/SauceDemo_InventoryPage.robot
Resource          ../../../resources/PageObject/Keywords/UI_Keywords/SauceDemo_Header.robot
Test Setup        Open SauceDemo
Test Teardown     Close SauceDemo
Test Timeout      2 minutes
Test Tags         ui    login


*** Test Cases ***
Valid Login Opens Products Page
    [Tags]    smoke
    Log In As Standard User
    Inventory Page Should Be Open

Locked Out User Cannot Log In
    [Tags]    negative
    Log In As    ${LOCKED_OUT_USER}    ${SAUCE_PASSWORD}
    Login Error Should Be    ${LOCKED_OUT_ERROR}
    Login Page Should Be Open

Invalid Credentials Are Rejected
    [Tags]    negative
    [Template]    Login Should Fail With Error
    ${SAUCE_USER}      ${WRONG_PASSWORD}    ${INVALID_CREDENTIALS_ERROR}
    ${UNKNOWN_USER}    ${SAUCE_PASSWORD}    ${INVALID_CREDENTIALS_ERROR}
    ${EMPTY}           ${SAUCE_PASSWORD}    ${USERNAME_REQUIRED_ERROR}
    ${SAUCE_USER}      ${EMPTY}             ${PASSWORD_REQUIRED_ERROR}

Logout Returns To Login Page
    [Tags]    smoke
    Log In As Standard User
    Inventory Page Should Be Open
    Log Out
    Login Page Should Be Open
    Go To Inventory Page
    Login Error Should Be    ${LOGIN_REQUIRED_ERROR}

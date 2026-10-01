*** Settings ***
Documentation    Login page of saucedemo.com.
Resource         SauceDemo_Common.robot
Variables        ../../UI_Locators/SauceDemo_LoginPage.py


*** Keywords ***
Login Page Should Be Open
    Wait Until Element Is Visible    ${LOGIN_BUTTON}
    Element Should Be Visible    ${LOGIN_USERNAME_INPUT}
    Element Should Be Visible    ${LOGIN_PASSWORD_INPUT}

Log In As
    [Arguments]    ${username}    ${password}
    Input Text        ${LOGIN_USERNAME_INPUT}    ${username}
    Input Password    ${LOGIN_PASSWORD_INPUT}    ${password}
    Click Button      ${LOGIN_BUTTON}

Log In As Standard User
    Log In As    ${SAUCE_USER}    ${SAUCE_PASSWORD}

Login Error Should Be
    [Arguments]    ${expected_message}
    Wait Until Element Is Visible    ${LOGIN_ERROR_MESSAGE}
    Element Text Should Be    ${LOGIN_ERROR_MESSAGE}    ${expected_message}

Login Should Fail With Error
    [Documentation]    Logs in from a freshly loaded login page and expects ``expected_message``.
    [Arguments]    ${username}    ${password}    ${expected_message}
    Go To    ${SAUCEDEMO_URL}
    Login Page Should Be Open
    Log In As    ${username}    ${password}
    Login Error Should Be    ${expected_message}
    Login Page Should Be Open

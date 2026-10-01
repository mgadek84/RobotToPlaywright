*** Settings ***
Documentation    Header (cart badge) and side menu of saucedemo.com, available on every page after login.
Resource         SauceDemo_Common.robot
Variables        ../../UI_Locators/SauceDemo_Header.py


*** Keywords ***
Cart Badge Should Show
    [Arguments]    ${expected_count}
    Wait Until Element Is Visible    ${HEADER_CART_BADGE}
    Wait Until Keyword Succeeds    ${UI_TIMEOUT}    200ms
    ...    Element Text Should Be    ${HEADER_CART_BADGE}    ${expected_count}

Cart Badge Should Not Be Shown
    Wait Until Page Does Not Contain Element    ${HEADER_CART_BADGE}

Log Out
    Click Button    ${HEADER_MENU_BUTTON}
    Wait Until Element Is Visible    ${HEADER_LOGOUT_LINK}
    Click Link    ${HEADER_LOGOUT_LINK}

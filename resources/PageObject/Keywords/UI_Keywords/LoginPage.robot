*** Settings ***
Documentation  Example tests related only to Landing Page
Library    SeleniumLibrary
Library    base64
Library    SikuliLibrary  mode=NEW
Resource   ../../../../config.properties/config.properties.robot
Variables  ../../Locators/Example_LoginPage.py
Variables  ../../Locators/Example_Common.py
Variables  ../../TestData/Example_Testdata.py


*** Variables ***
${decoded_password}  ${EMPTY}
${decoded_two_fa}  ${EMPTY}
${first_name}  Test
${last_name}  Automation
${email_address}  example@example.com
${request_message}  It`s a test
${landing_page_url}  https://example.com/#/


*** Keywords ***
Log into Example
    [Documentation]   Complet Login into Example Marketplace
    Example_LoginPage.Login button displayed
    Example_LoginPage.Input Login Email
    Example_LoginPage.Input Password
    Example_LoginPage.Input TwoFA
    Example_LoginPage.Click Login button
    Wait Until Keyword Succeeds  10x  100ms  Wait Until Element Is Not Visible    ${ALL_PAGES_BUTTON_LOADER}

Need help input data
    [Documentation]   Complete input data into Support Request
    Example_LoginPage.Input First Name Text
    Example_LoginPage.Input Last Name Text
    Example_LoginPage.Input Email
    Example_LoginPage.Input Request Details

Input Login Email
    [Documentation]   Type user`s email
    SeleniumLibrary.Input Text     ${email_input}    ${EXAMPLE_EMAIL}

Input Password
    [Documentation]   Decode previously encoded password. Type it
    Set Log Level  NONE
    ${decoded_password}=  Evaluate  base64.b64decode('${EXAMPLE_PASSWORD}').decode('utf-8')
    Set Suite Variable  ${decoded_password}
    SeleniumLibrary.Input Text     ${password_input}  ${decoded_password}

Input TwoFA
    [Documentation]   Decode previously encoded TwoFA. Type it.
    Set Log Level  NONE
    ${decoded_two_fa}=  Evaluate  base64.b64decode('${EXAMPLE_TWOFA}').decode('utf-8')
    Set Suite Variable  ${decoded_two_fa}
    SeleniumLibrary.Input Text     ${two_factor_input}    ${decoded_two_fa}

Click Login button
    [Documentation]   Locate and click Login button on a home page
    Wait Until Keyword Succeeds   5x  1000ms  Click Button     ${login_btn}

Login button displayed
    [Documentation]   Waiting for element to be resented on a page
    Wait Until Element Is Visible        ${login_btn}

Click Need Help button
    [Documentation]   Need Help button on a landing page
    Wait Until Keyword Succeeds   5x  1000ms  Click Button   ${need_help_btn}

Input First Name Text
    [Documentation]   First Name input string
    Wait Until Keyword Succeeds  5x  1000ms  SeleniumLibrary.Input Text   ${first_name_input}   ${first_name}

Input Last Name Text
    [Documentation]   Last Name input string
    Wait Until Keyword Succeeds  5x  1000ms  SeleniumLibrary.Input Text  ${last_name_input}  ${last_name}

Input Email
    [Documentation]   Email input string
    Wait Until Keyword Succeeds  5x  1000ms  SeleniumLibrary.Input Text  ${email_address_input}  ${email_address}

Input Request Details
    [Documentation]   Message Input string
    SeleniumLibrary.Input Text  ${request_details_input}  ${request_message}

Click Submit button
    [Documentation]   Locate and Click "Submit" button
    Wait Until Keyword Succeeds  5x  1000ms  Click Button  ${submit_btn}
    Wait Until Keyword Succeeds  10x  100ms  Wait Until Element Is Not Visible    ${ALL_PAGES_BUTTON_LOADER}

Positive toast message popup
    [Documentation]   Success Toast message displayed and assert by partial text
    Wait Until Keyword Succeeds  5x  500ms  wait until element is visible  ${toast_message_success}
    ${expected_text}=   SeleniumLibrary.Get Text  ${toast_success_text}
    Should Contain  ${expected_text}   Your request has been received

Verify URL
    [Documentation]   Verify URL provided
    [Arguments]    ${verify_url}
    Wait Until Keyword Succeeds  3x  5000ms    Location Should Be    ${verify_url}
    Set Log Level    INFO
    Log    verify_url: ${verify_url}

Verify Header Graphic
    [Documentation]   Verify the Example Network logo in the page Header
    Log    Test in progress
    Sleep  10
    Wait Until Screen Contain    example_homepage_logo.png    timeout=20


*** Settings ***
Documentation   Tests used across Example platform. General tests to enchance functionality
Library         SeleniumLibrary
Library         SikuliLibrary  mode=NEW
Library         OperatingSystem
Resource        ../../../config.properties/config.properties.robot
Variables       ../Example_Locators/Example_LoginPage.py
Variables       ../Example_Locators/Example_NetworkPage.py
Variables       ../Example_Locators/Example_Common.py
Variables       ../TestData/Example_Testdata.py

*** Variables ***
${EXAMPLE_IMAGE_DIR}    ./resources/PageObject/Example_SikuliX_Images

*** Keywords ***
SikuliX Test Start
    [documentation]  Runs before each SikuliX testcase.
    Start Sikuli Process
    IF    '${BROWSER}'=='Edge'
        Opening Browser Edge
    ELSE
        Opening Browser Chrome or Firefox
    END
    Add Needed Image Path

SikuliX Test Close
    [documentation]  TODO
    SeleniumLibrary.Capture Page Screenshot
    Close All Browsers
    # CleanDirectory Sikuli

SikuliX Stop Remote Server
    [documentation]  TODO
    SikuliLibrary.Stop Remote Server

Add Needed Image Path
    SikuliLibrary.Add Image Path    ${EXAMPLE_IMAGE_DIR}

CleanDirectory Sikuli
    Empty Directory    sikuli_captured/

Setup Screenshot on Failure
    [Documentation]  Setup screenshot directory and register keywork
    # Uncomment below line if you want to capture screenshot after EVERY failure
    Run Keyword If Test Failed    Capture Page Screenshot  EMBED
    Close All Browsers

Begin Webtest
    [Documentation]  Used to open Browser. Runs before each testcase.
    ...    Sets screenshot directory for Pabot, opens Browser, then logs Browser and Testname
    Set Selenium Speed  2s
    IF    '${BROWSER}'=='Edge'
        Opening Browser Edge
    ELSE
        Opening Browser Chrome or Firefox
    END
    Wait Until Element Is Visible  ${login_btn}  timeout=10
    Log Browser and Test Name To Console
    Set Selenium Speed  0s

End Webtest
    [Documentation]   After each test it will close all automated browsers used by framework
    # For troubleshooting purposes only
    # SeleniumLibrary.Capture Page Screenshot    custom_with_index_{index}.png
    [Teardown]  Setup Screenshot on Failure
    Set Log Level    Info

Opening Browser Chrome or Firefox
    [Documentation]   Open Browser, Take a screenshot at the end of the test. Assert Landing page.
    Set Selenium Speed  2s
    Open Browser    ${EXAMPLE_LOGINPAGE_URL}    ${BROWSER}
    # ****Need to maximize browser to pass in gitlab****
    Set Window Size  ${RESOLUTION_HORIZONTAL}  ${RESOLUTION_VERTICAL}
    Set Log Level    Trace
    Location Should Be    ${EXAMPLE_LOGINPAGE_URL}
    Set Selenium Speed  0s

Opening Browser Edge
    [Documentation]   Open Browser, Take a screenshot at the end of the test. Assert Landing page.
    Set Selenium Speed  2s
    Open Browser    ${EXAMPLE_LOGINPAGE_URL}    ${BROWSER}    options=add_argument("--no-sandbox");binary_location("/opt/robotframework/bin/microsoft-edge")
    # ****Need to maximize browser to pass in gitlab****
    Set Window Size  ${RESOLUTION_HORIZONTAL}  ${RESOLUTION_VERTICAL}
    Set Log Level    Trace
    Location Should Be    ${EXAMPLE_LOGINPAGE_URL}
    Set Selenium Speed  0s

Log Browser and Test Name To Console
    [Documentation]   Log to report Browser and name of the Test
    Log    Browsers: ${BROWSER} console=yes
    Log    Title: ${TEST_NAME} console=yes

Logout From Active User
    [Documentation]   After each test with login this test used to log out and assert message on a page
    Set Selenium Speed  2s
    Wait Until Keyword Succeeds  5x  2000ms   Wait Until Element Is Visible        ${LOGOUT_BTN}
    Wait Until Keyword Succeeds  5x  2000ms   Click Element        ${LOGOUT_BTN}
    Wait Until Keyword Succeeds  5x  500ms    Wait Until Element is Visible  ${log_out_msg}    10s
    Set Selenium Speed  0s

Loader Spinner Disappear
    [Documentation]    Loader that is presented across all pages. Waits until it disappears if the application is loading slow.
    [Arguments]    ${timeout}=60
    Wait Until Keyword Succeeds    10x    100ms    Wait Until Element Is Not Visible    ${ALL_PAGES_MARKETPLACE_LOADING}
    ${start_time}=    Get Time    epoch
    ${end_time}=    Evaluate    ${start_time} + ${timeout}
    ${loader_spinner_spinning}=    Set Variable    0
    FOR    ${current_time}    IN RANGE    ${start_time}    ${end_time}
        ${status}    ${value}=    Run Keyword And Ignore Error    Wait Until Element Is Not Visible    ${ALL_PAGES_LOADER}
        IF    '${status}' == 'PASS'
            ${loader_spinner_spinning}=    Evaluate    ${loader_spinner_spinning} + 1
        ELSE
            ${loader_spinner_spinning}=    Set Variable    0
        END
        IF    ${loader_spinner_spinning} == 2
            Exit For Loop
        END
    END
    IF    ${loader_spinner_spinning} < 2
        Fail    Timeout reached before the ${ALL_PAGES_LOADER} disappeared.
    END

# This Keyword is for troubleshooting purposes only. Please keep commented.
#Browser Settings
#    [Documentation]   Select browser. Set Window size and slowdown selenium tests 1 for each action
#    IF    '${BROWSER}'=='Edge'
#        Wait Until Keyword Succeeds  5x  2000ms  Open Browser	 ${EXAMPLE_LOGINPAGE_URL}   ${BROWSER}    options=add_argument("--no-sandbox");binary_location("/opt/robotframework/bin/microsoft-edge")
#    ELSE
#        Wait Until Keyword Succeeds  5x  2000ms  Open Browser	 ${EXAMPLE_LOGINPAGE_URL}   ${BROWSER}
#    END
##    Maximize Browser Window
#    Set Window Size  ${RESOLUTION_HORIZONTAL}  ${RESOLUTION_VERTICAL}
#    Set Selenium Speed  200ms
# This Keyword is for troubleshooting purposes only. Please keep commented.
# Setup Screenshots
#     [Documentation]  Setup screenshot directory and register keywork
#     # Uncomment below line if you want to capture screenshot after EVERY failure
#     Register Keyword To Run On Failure	Capture Page Screenshot

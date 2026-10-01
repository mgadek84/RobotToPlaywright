*** Settings ***
Documentation    Browser lifecycle for the saucedemo.com UI suite.
Library          SeleniumLibrary    run_on_failure=Capture Page Screenshot    screenshot_root_directory=EMBED
Resource         ../../../../config.properties/config.properties.robot
Variables        ../../TestData/SauceDemo_TestData.py


*** Variables ***
${HEADLESS_WINDOW_SIZE}     1920,1080
# Chrome flags the public demo password as "found in a data breach" and opens a dialog over the page.
&{CHROME_PREFS}             credentials_enable_service=${False}
...                         profile.password_manager_enabled=${False}
...                         profile.password_manager_leak_detection=${False}


*** Keywords ***
Open SauceDemo
    [Documentation]    Starts a fresh browser on the saucedemo login page.
    ...    Runs without a visible window when ``HEADLESS`` is true.
    ${headless}=    Headless Mode Is Enabled
    ${options}=    Get Browser Options    ${headless}
    Open Browser    ${SAUCEDEMO_URL}    ${UI_BROWSER}    options=${options}
    Set Selenium Timeout    ${UI_TIMEOUT}
    IF    not ${headless}    Maximize Browser Window

Close SauceDemo
    Close All Browsers

Headless Mode Is Enabled
    ${enabled}=    Evaluate    str($HEADLESS).strip().lower() in ("true", "1", "yes", "on")
    RETURN    ${enabled}

Get Browser Options
    [Documentation]    Chromium options (Chrome or Edge) in SeleniumLibrary's ``options`` string format.
    [Arguments]    ${headless}
    ${options}=    Catenate    SEPARATOR=;
    ...    add_argument("--disable-search-engine-choice-screen")
    ...    add_experimental_option("prefs", ${CHROME_PREFS})
    IF    ${headless}
        ${options}=    Catenate    SEPARATOR=;    ${options}
        ...    add_argument("--headless=new")
        ...    add_argument("--window-size=${HEADLESS_WINDOW_SIZE}")
    END
    RETURN    ${options}

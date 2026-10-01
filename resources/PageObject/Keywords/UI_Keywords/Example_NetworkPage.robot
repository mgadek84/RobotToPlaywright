*** Settings ***
Documentation   Keywords for Example Network page interactions
Library         SeleniumLibrary
Resource        ../../../../config.properties/config.properties.robot
Variables       ../../UI_Locators/Example_NetworkPage.py

*** Keywords ***
Navigate To Network Page
    [Documentation]    Navigate to the network page
    Go To    ${BASE_URL}/network

Verify Network Page Vendors Catalogue is Visible
    [Documentation]    Stub — verify vendors catalogue is visible on Network Page
    Log    Verifying Network Page Vendors Catalogue is Visible    WARN

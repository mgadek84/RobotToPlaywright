*** Settings ***
Documentation   Keywords for Example Network page interactions
Library         SeleniumLibrary
Resource        ../../../../config.properties/config.properties.robot
Variables       ../../Locators/Example_NetworkPage.py

*** Keywords ***
Navigate To Network Page
    [Documentation]    Navigate to the network page
    Go To    ${BASE_URL}/network

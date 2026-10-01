*** Settings ***
Documentation   Keywords for Example Home page interactions
Library         SeleniumLibrary
Resource        ../../../../config.properties/config.properties.robot

*** Keywords ***
Navigate To Home Page
    [Documentation]    Navigate to the home page
    Go To    ${BASE_URL}

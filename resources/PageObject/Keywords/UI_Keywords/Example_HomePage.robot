*** Settings ***
Documentation   Keywords for Example Home page interactions
Library         SeleniumLibrary
Resource        ../../../../config.properties/config.properties.robot

*** Keywords ***
Navigate To Home Page
    [Documentation]    Navigate to the home page
    Go To    ${BASE_URL}

Verify Home Page
    [Documentation]    Stub — verify the home page is loaded
    Log    Verifying Home Page    WARN

'My Vendors' table input name
    [Documentation]    Stub — input vendor name into My Vendors search
    Log    Inputting vendor name into My Vendors table    WARN

'My Vendors' table search results in the 'Name' column
    [Documentation]    Stub — assert search results in the Name column
    Log    Asserting My Vendors table Name column results    WARN

Home Page 'My Vendors' Pagination
    [Documentation]    Stub — test My Vendors table pagination
    Log    Testing My Vendors pagination    WARN

Find and assert 'Request Assessment' button
    [Documentation]    Stub — find and assert Request Assessment button
    Log    Finding Request Assessment button    WARN

Click 'Submit' button
    [Documentation]    Stub — click the Submit button
    Log    Clicking Submit button    WARN

Success Toast Message
    [Documentation]    Stub — assert success toast message
    Log    Asserting success toast message    WARN

Find and click 'Tier' hyperlink in 'Risk Tier' column
    [Documentation]    Stub — click Tier hyperlink in Risk Tier column
    Log    Clicking Tier hyperlink in Risk Tier column    WARN

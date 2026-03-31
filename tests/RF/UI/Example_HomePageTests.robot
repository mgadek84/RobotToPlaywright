*** Settings ***
Documentation     Tests covering UI functionality on a Home Page of Example Marketplace application.
Resource          ../../../resources/PageObject/Keywords/Example_NetworkPage.robot
Resource          ../../../resources/PageObject/Keywords/Example_Common.robot
Resource          ../../../resources/PageObject/Keywords/Example_HomePage.robot
Test Setup        Begin Webtest
Test Teardown     End Webtest
Test Timeout      15 minutes

*** Variables ***

*** Test Cases ***
Navigate to a Home Page
    [Documentation]   Navigate to a Home Page. Assert Element on a page
    [Tags]  smoke   home_page   example  ui
    Example_LoginPage.Log into Example
    Example_HomePage.Verify Home Page
    Example_Common.Logout From Active User

Home page 'Request Assessment' button
    [Documentation]   Navigate to a Home Page. Click Request Assessment button. Assert Toast message
    [Tags]  smoke  home_page  example  ui
    Example_LoginPage.Log into Example
    Example_HomePage.Verify Home Page
    Example_HomePage.Find and assert 'Request Assessment' button
    Example_HomePage.Click 'Submit' button
    Example_HomePage.Success Toast Message
    Example_Common.Logout From Active User

# https://example.atlassian.net/browse/Example-2558
#Home Page verify 'Bulk Upload Vendors' button works
#    [Documentation]  Navigate to a Home Page. Click Bulk Upload Vendors button. Verify Imports page
#    [Tags]  home_page  example  smoke  ui
#    Example_LoginPage.Log into Example
#    Example_HomePage.Verify Home Page
#    Example_HomePage.Click 'Bulk Upload Vendors' button
#    Example_HomePage.Verify Imports Page
#    Example_Common.Logout From Active User

Home Page 'My Vendors' table Pagination
    [Documentation]   Navigate to a Home Page. In "My Vendors" table click "Next", then click "Previous" and assert that page changed and data in the tables is not equal.
    [Tags]  smoke   home_page   example  ui  vendors_table
    Example_LoginPage.Log into Example
    Example_HomePage.Verify Home Page
    Example_HomePage.Home Page 'My Vendors' Pagination
    Example_Common.Logout From Active User

Home Page 'My Vendors' table vendor search
    [Documentation]  Search For vendor by the name on a Home Page in My Vendors Table and assert result
    [Tags]  home_page  example  smoke  ui  vendors_table
    Example_LoginPage.Log into Example
    Example_HomePage.Verify Home Page
    Example_HomePage.'My Vendors' table input name
    Example_HomePage.'My Vendors' table search results in the 'Name' column
    Example_Common.Logout From Active User

Home Page 'My Vendors' table tier rank hyperlink
    [Documentation]  Search for Vendor. Click on a tier rank and assert correct page loaded
    [Tags]  home_page  example  smoke  ui  vendors_table  risk_rank
    Example_LoginPage.Log into Example
    Example_HomePage.Verify Home Page
    Example_HomePage.'My Vendors' table input name
    Example_HomePage.'My Vendors' table search results in the 'Name' column
    Example_HomePage.Find and click 'Tier' hyperlink in 'Risk Tier' column
    Example_Common.Logout From Active User


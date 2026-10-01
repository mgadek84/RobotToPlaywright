*** Settings ***
Resource          ../../../resources/PageObject/Keywords/UI_Keywords/Example_NetworkPage.robot
Resource          ../../../resources/PageObject/Keywords/UI_Keywords/Example_Common.robot
Resource          ../../../resources/PageObject/Keywords/UI_Keywords/Example_LoginPage.robot
Test Setup        Begin Webtest
Test Teardown     End Webtest
Test Timeout      15 minutes

*** Variables ***

*** Test Cases ***
Verify Example Login
    [Documentation]   Test Case Verifies LogIn into user account. Assert Catalogue displayed
    [Tags]    smoke   login_example
    Example_LoginPage.Log into Example
    Example_NetworkPage.Verify Network Page Vendors Catalogue is Visible
    Example_Common.Logout From Active User

Verify Need Help button works
    [Documentation]   Test Case Verifies that Need Help Button Works and Toast message displayed
    [Tags]   smoke   login_example
    Example_LoginPage.Click Need Help button
    Example_LoginPage.Need help input data
    Example_LoginPage.Click Submit button
    Example_LoginPage.Positive toast message popup


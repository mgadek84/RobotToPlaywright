*** Settings ***
Documentation     saucedemo.com product list, sorting and cart badge, as the standard user.
Resource          ../../../resources/PageObject/Keywords/UI_Keywords/SauceDemo_LoginPage.robot
Resource          ../../../resources/PageObject/Keywords/UI_Keywords/SauceDemo_InventoryPage.robot
Resource          ../../../resources/PageObject/Keywords/UI_Keywords/SauceDemo_Header.robot
Test Setup        Open SauceDemo And Log In
Test Teardown     Close SauceDemo
Test Timeout      2 minutes
Test Tags         ui    inventory


*** Test Cases ***
Product List Shows All Products
    [Tags]    smoke
    Product Count Should Be    ${EXPECTED_PRODUCT_COUNT}
    Product Names Should Be    ${EXPECTED_PRODUCT_NAMES}
    Active Sort Option Should Be    ${DEFAULT_SORT_OPTION}

Products Can Be Sorted
    [Template]    Sorting Should Order Products
    Name (Z to A)          name     descending
    Name (A to Z)          name     ascending
    Price (low to high)    price    ascending
    Price (high to low)    price    descending

Adding Products Updates Cart Badge
    [Tags]    smoke    cart
    Cart Badge Should Not Be Shown
    Add Product To Cart    ${BACKPACK}
    Cart Badge Should Show    1
    Add Product To Cart    ${BIKE_LIGHT}
    Cart Badge Should Show    2

Removing Product Updates Cart Badge
    [Tags]    cart
    Add Product To Cart    ${BACKPACK}
    Add Product To Cart    ${BIKE_LIGHT}
    Cart Badge Should Show    2
    Remove Product From Cart    ${BACKPACK}
    Cart Badge Should Show    1
    Remove Product From Cart    ${BIKE_LIGHT}
    Cart Badge Should Not Be Shown


*** Keywords ***
Open SauceDemo And Log In
    Open SauceDemo
    Log In As Standard User
    Inventory Page Should Be Open

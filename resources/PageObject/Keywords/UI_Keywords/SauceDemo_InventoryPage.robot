*** Settings ***
Documentation    Products (inventory) page of saucedemo.com.
Library          Collections
Library          String
Resource         SauceDemo_Common.robot
Variables        ../../UI_Locators/SauceDemo_InventoryPage.py


*** Keywords ***
Go To Inventory Page
    Go To    ${SAUCEDEMO_URL.rstrip('/')}${INVENTORY_PATH}

Inventory Page Should Be Open
    Wait Until Element Is Visible    ${INVENTORY_TITLE_LABEL}
    Element Text Should Be    ${INVENTORY_TITLE_LABEL}    ${INVENTORY_TITLE}
    Location Should Contain    ${INVENTORY_PATH}

Product Count Should Be
    [Arguments]    ${expected_count}
    ${count}=    Get Element Count    ${INVENTORY_ITEM}
    Should Be Equal As Integers    ${count}    ${expected_count}

Get Product Names
    ${elements}=    Get WebElements    ${INVENTORY_ITEM_NAME}
    ${names}=    Evaluate    [element.text for element in $elements]
    RETURN    ${names}

Get Product Prices
    ${elements}=    Get WebElements    ${INVENTORY_ITEM_PRICE}
    ${prices}=    Evaluate    [float(element.text.lstrip("$")) for element in $elements]
    RETURN    ${prices}

Product Names Should Be
    [Arguments]    ${expected_names}
    ${names}=    Get Product Names
    Lists Should Be Equal    ${names}    ${expected_names}

Active Sort Option Should Be
    [Arguments]    ${option_label}
    Element Text Should Be    ${INVENTORY_ACTIVE_SORT_OPTION}    ${option_label}

Sort Products By
    [Arguments]    ${option_label}
    Select From List By Label    ${INVENTORY_SORT_SELECT}    ${option_label}
    Active Sort Option Should Be    ${option_label}

Sorting Should Order Products
    [Documentation]    Picks ``option_label`` from the sort menu and checks that the products are
    ...    ordered by ``field`` (``name`` or ``price``) in ``direction`` (``ascending`` or ``descending``).
    [Arguments]    ${option_label}    ${field}    ${direction}
    Sort Products By    ${option_label}
    ${values}=    IF    $field == "price"    Get Product Prices    ELSE    Get Product Names
    ${expected}=    Evaluate    sorted($values, reverse=$direction == "descending")
    Lists Should Be Equal    ${values}    ${expected}

Product Button Locator
    [Documentation]    Locator of the Add to cart / Remove button on the card of ``product_name``.
    [Arguments]    ${product_name}
    ${locator}=    Format String    ${INVENTORY_ITEM_BUTTON_BY_NAME}    name=${product_name}
    RETURN    ${locator}

Add Product To Cart
    [Arguments]    ${product_name}
    ${button}=    Product Button Locator    ${product_name}
    Element Text Should Be    ${button}    Add to cart
    Click Button    ${button}
    Wait Until Element Contains    ${button}    Remove

Remove Product From Cart
    [Arguments]    ${product_name}
    ${button}=    Product Button Locator    ${product_name}
    Element Text Should Be    ${button}    Remove
    Click Button    ${button}
    Wait Until Element Contains    ${button}    Add to cart

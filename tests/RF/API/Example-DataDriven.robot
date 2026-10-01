*** Settings ***
Documentation       Data-driven API tests for the Products endpoint.
...                 Each row in the template table is an independent test case.
...                 All cases run in parallel via pabot alongside the UI suite.
Resource            ../../../resources/PageObject/Keywords/API_Keywords/Example-Products.robot
Resource            ../../../resources/PageObject/Keywords/API_Keywords/Example-Common.robot
Library             ../../../resources/Libraries/CustomKeywords.py
Test Timeout        30 seconds


*** Test Cases ***

# ------------------------------------------------------------------
# Status code validation — one template, multiple input combinations
# ------------------------------------------------------------------

Validate Products Endpoint Response Codes
    [Documentation]    Verifies that the products endpoint returns the correct
    ...                HTTP status code for a range of auth and filter scenarios.
    [Template]         GET Products And Validate Status Code
    #  bearer_token             filter_param    expected_status
    ${VALID_BEARER}             ${EMPTY}        200
    ${VALID_BEARER}             name            200
    ${VALID_BEARER}             vendor          200
    ${INVALID_BEARER}           ${EMPTY}        401
    ${EMPTY}                    ${EMPTY}        401


# ------------------------------------------------------------------
# Pagination boundary tests
# ------------------------------------------------------------------

Validate Products Pagination Boundaries
    [Documentation]    Verifies pagination parameters return correct status codes.
    [Template]         GET Products With Pagination And Validate
    #  page    pageSize    expected_status
    1           25          200
    1           100         200
    1           0           400
    0           25          400
    -1          25          400


# ------------------------------------------------------------------
# Sorting parameter tests
# ------------------------------------------------------------------

Validate Products Sort Parameter
    [Documentation]    Verifies the sort direction parameter is handled correctly.
    [Template]         GET Products With Sort And Validate
    #  sort_field    direction    expected_status
    name             asc          200
    name             desc         200
    vendor           asc          200
    invalid_field    asc          400
    name             invalid      400


*** Keywords ***

GET Products And Validate Status Code
    [Arguments]    ${token}    ${filter}    ${expected_status}
    ${response}=    Get Products Request    bearer_token=${token}    filter=${filter}
    Validate Response Status Code    ${response}    ${expected_status}

GET Products With Pagination And Validate
    [Arguments]    ${page}    ${page_size}    ${expected_status}
    ${response}=    Get Products Request    page=${page}    pageSize=${page_size}
    Validate Response Status Code    ${response}    ${expected_status}

GET Products With Sort And Validate
    [Arguments]    ${sort_field}    ${direction}    ${expected_status}
    ${response}=    Get Products Request    sort=${sort_field}    asc=${direction}
    Validate Response Status Code    ${response}    ${expected_status}

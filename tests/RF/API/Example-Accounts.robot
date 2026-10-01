*** Settings ***
Documentation    Example API Test
Resource         ../../../resources/PageObject/Keywords/API_Keywords/Example-Accounts.robot
Resource         ../../../resources/PageObject/Keywords/API_Keywords/Example-Common.robot
Resource         ../../../config.properties/config.properties.robot
Library          SeleniumLibrary
Test Timeout     60 seconds

*** Variables ***
${json_variable}    jsonplaceholder

*** Test Cases ***
# Filter parameter. The unique identifier of the subscriber.
Example Accounts By ID
    [Documentation]  Test Case assert 200 status code. Verifis that id is equal to id in response
    [Tags]  Example  API  ACCOUNTS  SMOKE  ALL  200  GET
    Create Session by URL    ${EXAMPLE_URL}
    Example Get Bearer token
    Create Session by URL    ${EXAMPLE_URL}
    Example Accounts By ID

Example GET Accounts Unauthorized user
    [Documentation]  GET /api-v1/accounts Test without authorization. Assert response 401
    [Tags]  Example  API  ACCOUNTS  SMOKE  ALL  401  GET
    Example Deauth
    Create Unauthorized Session by URL    ${EXAMPLE_URL}
    Example GET Accounts Unauthorized user

Example Accounts
    [Documentation]  Send request without parameters. Loop through all ID. Assert ID is not empty.
    [Tags]  Example  API  ACCOUNTS  ALL  200   GET
    Create Session by URL    ${EXAMPLE_URL}
    Example Get Bearer token
    Create Session by URL    ${EXAMPLE_URL}
    Example Accounts

# Filter parameter. Case-insensitive. Partial match. The name of the subscriber.
Example Accounts By Name
   [Documentation]  Test Case assert 200 status code. Verifis that Name is equal to name in response
   [Tags]  Example  API  ACCOUNTS  200  ALL   GET
   Create Session by URL    ${EXAMPLE_URL}
   Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Accounts By Name

# Filter parameter. Case-insensitive. Partial match. Can drop the "www." part. The website of the subscriber.
Example Accounts By Domain
    [Documentation]  Test Case assert 200 status code. Verifis that domain is equal to website in response
    [Tags]  Example  API  ACCOUNTS  ALL  200  GET
    Create Session by URL    ${EXAMPLE_URL}
    Example Get Bearer token
    Create Session by URL    ${EXAMPLE_URL}
    Example Accounts By Domain

# Filter parameter. Case-insensitive. Partial match. The email address of the subscriber.
Example Accounts By emailAddress
    [Documentation]  Test Case assert 200 status code. Verifis that emailAddress is equal to emailAddress in response
    [Tags]  Example  API  ACCOUNTS  ALL  200  GET
    Create Session by URL    ${EXAMPLE_URL}
    Example Get Bearer token
    Create Session by URL    ${EXAMPLE_URL}
    Example Accounts By emailAddress

# Filter parameter. Show deleted Accounts as well.
Example Accounts By showDeleted
    [Documentation]  Assert 200. Set showDeleted as true. Loop vendor name, verify that name is equal to name
    [Tags]  Example  API  ACCOUNTS  ALL  200  GET
    Create Session by URL    ${EXAMPLE_URL}
    Example Get Bearer token
    Create Session by URL    ${EXAMPLE_URL}
    Example Accounts showDeleted

# A common identifier for all messages of a given HTTP request.
Example Accounts by x-request-id
    [Documentation]  Get /api-v1/accounts. Assert 200. Assert Id is not empty.
    [Tags]  Example  API  ACCOUNTS  ALL  200  GET
    Create Session by URL    ${EXAMPLE_URL}
    Example Get Bearer token
    Create Session by URL    ${EXAMPLE_URL}
    Example Accounts by x-request-id

# Filter parameter. If true - only Accounts that are linked to a vendor. If false - only Accounts that are not linked to any vendor.
Example Accounts by linked as true
    [Documentation]  Get /api-v1/accounts. Assert 200. Parameter linked. Assert Id is not empty.
    [Tags]  Example  API  ACCOUNTS  ALL  200  GET
    Create Session by URL    ${EXAMPLE_URL}
    Example Get Bearer token
    Create Session by URL    ${EXAMPLE_URL}
    Example Accounts by linked as true

# Filter parameter. If true - only Accounts that are linked to a vendor. If false - only Accounts that are not linked to any vendor.
Example Accounts by linked as false
    [Documentation]  Get /api-v1/accounts. Assert 200. Parameter linked. Assert Id is not empty.
    [Tags]  Example  API  ACCOUNTS  ALL  200  GET
    Create Session by URL    ${EXAMPLE_URL}
    Example Get Bearer token
    Create Session by URL    ${EXAMPLE_URL}
    Example Accounts by linked as false

# Filter parameter. Show deleted Accounts as well.
Example Accounts showDeleted as false
    [Documentation]  Set showDeleted as false. Loop vendor name assert 200 and name is not empty
    [Tags]  Example  API  ACCOUNTS  ALL  200  GET
    Create Session by URL    ${EXAMPLE_URL}
    Example Get Bearer token
    Create Session by URL    ${EXAMPLE_URL}
    Example Accounts showDeleted as false

# Sort direction parameter. The direction of sorting the result records - asc (ascending) or desc (descending)
Example Accounts by asc as true
    [Documentation]  Get /api-v1/accounts. Assert 200. Parameter asc. Assert Id is not empty.
    [Tags]  Example  API  ACCOUNTS  ALL  200  GET
    Create Session by URL    ${EXAMPLE_URL}
    Example Get Bearer token
    Create Session by URL    ${EXAMPLE_URL}
    Example Accounts by asc as true

# Sort direction parameter. The direction of sorting the result records - asc (ascending) or desc (descending)
Example Accounts by asc as false
    [Documentation]  Get /api-v1/accounts. Assert 200. Parameter asc. Assert Id is not empty.
    [Tags]  Example  API  ACCOUNTS  ALL  200  GET
    Create Session by URL    ${EXAMPLE_URL}
    Example Get Bearer token
    Create Session by URL    ${EXAMPLE_URL}
    Example Accounts by asc as false

# Filter parameter. The unique identifier of the subscriber.
Example Accounts by invalid uuid
    [Documentation]  Get /api-v1/accounts. Assert totalRecords == 0
    [Tags]  Example  API  ACCOUNTS  ALL  200  GET
    Create Session by URL    ${EXAMPLE_URL}
    Example Get Bearer token
    Create Session by URL    ${EXAMPLE_URL}
    Example Accounts by invalid uuid

# Filter parameter. Case-insensitive. Partial match. The name of the subscriber.
Example Accounts by invalid name
    [Documentation]  Get /api-v1/accounts. Assert totalRecords == 0. Assert 200
    [Tags]  Example  API  ACCOUNTS  ALL  200  GET
    Create Session by URL    ${EXAMPLE_URL}
    Example Get Bearer token
    Create Session by URL    ${EXAMPLE_URL}
    Example Accounts by invalid name

# Filter parameter. Case-insensitive. Partial match. Can drop the "www." part. The website of the subscriber.
Example Accounts by invalid website
    [Documentation]  Get /api-v1/accounts. Assert totalRecords == 0. Assert 200
    [Tags]  Example  API  ACCOUNTS  ALL  200  GET
    Create Session by URL    ${EXAMPLE_URL}
    Example Get Bearer token
    Create Session by URL    ${EXAMPLE_URL}
    Example Accounts by invalid website

# Filter parameter. Case-insensitive. Partial match. The email address of the subscriber.
Example Accounts by invalid emailAddress
    [Documentation]  Get /api-v1/accounts. Assert totalRecords == 0. Assert 200
    [Tags]  Example  API  ACCOUNTS  ALL  200  GET
    Create Session by URL    ${EXAMPLE_URL}
    Example Get Bearer token
    Create Session by URL    ${EXAMPLE_URL}
    Example Accounts by invalid emailAddress

Example POST Accounts Unauthorized user
    [Documentation]  POST /api-v1/accounts  Assert 401
    [Tags]  Example  API  ACCOUNTS  ALL  401  POST  SMOKE
    Example Deauth
    Create Unauthorized Session by URL    ${EXAMPLE_URL}
    Example POST Accounts Unauthorized user

Example PUT Accounts Unauthorized user
    [Documentation]  PUT /api-v1/accounts  Assert 401
    [Tags]  Example  API  ACCOUNTS  ALL  401  PUT  SMOKE
    Example Deauth
    Create Unauthorized Session by URL    ${EXAMPLE_URL}
    Example PUT Accounts Unauthorized user

Example DELETE Accounts Unauthorized user
    [Documentation]  DELETE /api-v1/accounts  Assert 401
    [Tags]  Example  API  ACCOUNTS  ALL  401  DELETE  SMOKE
    Example Deauth
    Create Unauthorized Session by URL    ${EXAMPLE_URL}
    Example DELETE Accounts Unauthorized user

# Test may Fail if it repeats POST with same number 1000-9999
Example POST and DELETE 200 Accounts Smoke
   [Documentation]  POST /api-v1/accounts. Assert 200. Take created account and delete it.
   [Tags]  Example  API  ACCOUNTS  ALL  200  POST  SMOKE
   Create Session by URL    ${EXAMPLE_URL}
   Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   ${account_id}=  Example POST 200 Accounts Smoke
   Example DELETE 200 Accounts Smoke  ${account_id}


*** Settings ***
Documentation    EXAMPLE API Test
Resource         ../../../resources/PageObject/Example_Keywords/Example-Products.robot
Resource         ../../../resources/PageObject/Example_Keywords/Example-Common.robot
Resource         ../../../config.properties/config.properties.robot
Library          SeleniumLibrary
Test Timeout     90 seconds

*** Variables ***
${json_variable}    jsonplaceholder

*** Test Cases ***
Example Example Products Unauthorized user
   [Documentation]  Assert 401 response
   [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  401  SMOKE  ALL
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Products Unauthorized user

Example Example Products no parameters
   [Documentation]  GET /api-v1/products. 200. Loop through ID. No Parameters selected
   [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  200  ALL
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Products no parameters

Example Example Products parameter x-request-id
# A common identifier for all messages of a given HTTP request.
   [Documentation]  Get /api-v1/products. 200. Request with only parameter x-request-id. Assert ID is not empty.
   [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  200  ALL
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Products parameter x-request-id

Example Example Products parameter uuid
# Filter parameter. A comma separated list of unique identifiers of the products to be retrieved.
    [Documentation]  Get /api-v1/products. 200. Request with only parameter uuid.
    [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  200  SMOKE  ALL
    Create Session by URL    ${EXAMPLE_URL}
    Example Example Get Bearer token
    Create Session by URL    ${EXAMPLE_URL}
    Example Example Products parameter uuid

Example Example Products parameter name
# Filter parameter. Case-insensitive. Partial match. The case-insensitive name of the product to be retrieved.
   [Documentation]  Get /api-v1/products. 200. Request with only parameter name. Assert name is not empty.
   [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  200  ALL
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Products parameter name

Example Example Products parameter vendor
# Filter parameter. Case-insensitive. Partial match. The name of the vendor to which the resulting list of products should belong.
   [Documentation]  Get /api-v1/products. 200. Request with only parameter vendor. Assert vendor is not empty.
   [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  200  ALL
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Products parameter vendor

Example Example Products parameter vendorID
# Filter parameter. A comma separated list of unique identifiers of the vendors to which the resulting list of products should belong
   [Documentation]  Get /api-v1/products. 200. Request with only parameter vendorID. Assert vendorID is equal to request.
   [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  200  ALL
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Products parameter vendorID

Example Example Products parameter ddrrID
# Filter parameter. The data driven risk rank ID of the vendor by which products are created/distributed.
   [Documentation]  Get /api-v1/products. 200. Request with parameter ddrrID. Assert ID is not empty
   [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  200  ALL
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Products parameter ddrrID

Example Example Products parameter subscriber
# Subscriber Logic has been changed to true or false. 11/19/2024
# This Test case depends on a current subscription. The subscriber to which products are registered.
   [Documentation]  Get /api-v1/products  500. Request with parameter subscriber.
   [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  500  ALL
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Products parameter subscriber

Example Example Products parameter accountID
# Filter parameter. The unique identifier of the subscriber to which products are registered.
   [Documentation]  Get /api-v1/products. 200. Request with parameter accountID. Assert ID is not empty
   [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  200  ALL
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Products parameter accountID

Example Example Products parameter asc as true
# Sort direction parameter. The direction of sorting the result records - asc (ascending) or desc (descending)
   [Documentation]  Get /api-v1/products. 200. Request with parameter asc as true. Assert ID is not empty
   [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  200  ALL
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Products parameter asc as true

Example Example Products parameter asc as false
# Sort direction parameter. The direction of sorting the result records - asc (ascending) or desc (descending)
    [Documentation]  Get /api-v1/products. 200. Request with parameter asc as true. Assert ID is not empty
    [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  200  ALL
    Create Session by URL    ${EXAMPLE_URL}
    Example Example Get Bearer token
    Create Session by URL    ${EXAMPLE_URL}
    Example Example Products parameter asc as false

Example Example Products parameter sort by name
# Sort by parameter. The attribute to sort the result records by.
   [Documentation]  Get /api-v1/products. 200. Request with parameter sort by name. Assert name is not empty
   [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  200  ALL
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Products parameter sort by name

Example Example Products parameter sort by vendor
# Sort by parameter. The attribute to sort the result records by.
  [Documentation]  Get /api-v1/products. 200. Request with parameter sort by vendor. Assert vendor is not empty
  [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  200  ALL
  Create Session by URL    ${EXAMPLE_URL}
  Example Example Get Bearer token
  Create Session by URL    ${EXAMPLE_URL}
  Example Example Products parameter sort by vendor

Example Example Products incorrect parameter uuid
# Filter parameter. A comma separated list of unique identifiers of the products to be retrieved.
   [Documentation]  Get /api-v1/products. 400. Request with incorrect parameter uuid.
   [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  400  SMOKE  ALL
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Products incorrect parameter uuid

Example Example Products incorrect parameter name
# Filter parameter. Case-insensitive. Partial match. The case-insensitive name of the product to be retrieved.
   [Documentation]  Get /api-v1/products. 200. Request with incorrect parameter name. Assert totalRecords == 0
   [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  200  ALL
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Products incorrect parameter name

Example Example Products incorrect parameter vendor
# Filter parameter. Case-insensitive. Partial match. The name of the vendor to which the resulting list of products should belong.
   [Documentation]  Get /api-v1/products. 200. Request with incorrect parameter vendor. Assert totalRecords == 0
   [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  200  ALL
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Products incorrect parameter vendor

Example Example Products incorrect parameter vendorID
# Filter parameter. A comma separated list of unique identifiers of the vendors to which the resulting list of products should belong.
   [Documentation]  Get /api-v1/products. 200. Request with incorrect parameter vendor. Assert totalRecords == 0
   [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  200  ALL
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Products incorrect parameter vendorID

Example Example Products incorrect parameter ddrrID
# Filter parameter. The data driven risk rank ID of the vendor by which products are created/distributed.
   [Documentation]  Get /api-v1/products. 200. Request with incorrect parameter ddrrID. Assert totalRecords == 0
   [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  200  ALL
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Products incorrect parameter ddrrID

Example Example Products incorrect parameter subscriber
# Behavior has been changed. Returning 500
# Filter parameter. Case-insensitive. Partial match. The Case-insensitive name of the subscriber to which products are registered.
   [Documentation]  Get /api-v1/products. 500. Request with incorrect parameter subscriber
   [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  500  ALL
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Products incorrect parameter subscriber

Example Example Products parameter cve
# Filter parameter. Case-insensitive. Partial match. The common vulnerabilities and exposures of the product by which the list should be filtered
   [Documentation]  Get /api-v1/products. 200. Request with parameter cve. Assert totalRecords == 0
   [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  200  ALL
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Products parameter cve

Example Example Products incorrect parameter cve
# Filter parameter. Case-insensitive. Partial match. The common vulnerabilities and exposures of the product by which the list should be filtered
   [Documentation]  Get /api-v1/products. 200. Request with incorrect parameter cve. Assert totalRecords == 0
   [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  200  ALL
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Products incorrect parameter cve

Example Example Products incorrect parameter name and vendor
#   Filter parameter. Case-insensitive. Partial match. The version of the product by which the list should be filtered
   [Documentation]  Get /api-v1/products. 200. Request with incorrect parameter version and vendor. Assert totalRecords 0=0
   [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  200  ALL
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Products incorrect parameter name and vendor

Example Example Products parameter cpe
#   Filter parameter. Case-insensitive. Partial match. The common product enumeration of the product by which the list should be filtered
   [Documentation]  Get /api-v1/products. 200. Request with parameter cpe and vendor. Assert totalRecords != 0
   [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  200  ALL
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Products parameter cpe

Example Example Products incorrect parameter cpe
#   Filter parameter. Case-insensitive. Partial match. The common product enumeration of the product by which the list should be filtered
   [Documentation]  Get /api-v1/products. 200. Request with incorrect parameter cpe and vendor. Assert totalRecors == 0
   [Tags]  Example  EXAMPLE  API  PRODUCTS  GET  200  ALL
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Products incorrect parameter cpe

Example Example POST Products Unauthorized user
   [Documentation]  POST /api-v1/products. Assert 401 response.
   [Tags]  Example  EXAMPLE  API  PRODUCTS  POST  401  ALL  SMOKE
   Create Unauthorized Session by URL    ${EXAMPLE_URL}
   Example Example POST Products Unauthorized user

Example Example PUT Products Unauthorized user
   [Documentation]  PUT /api-v1/products. Assert 401 response.
   [Tags]  Example  EXAMPLE  API  PRODUCTS  PUT  401  ALL  SMOKE
   Create Unauthorized Session by URL    ${EXAMPLE_URL}
   Example Example PUT Products Unauthorized user

Example Example DELETE Products Unauthorized user
   [Documentation]  DELETE /api-v1/products. Assert 401 response.
   [Tags]  Example  EXAMPLE  API  PRODUCTS  DELETE  401  ALL  SMOKE
   Create Unauthorized Session by URL    ${EXAMPLE_URL}
   Example Example DELETE Products Unauthorized user

Example Example POST and DELETE 200 Products Smoke
   [Documentation]  POST /api-v1/products. Assert 200. Take created product and delete it.
   [Tags]  Example  EXAMPLE  API  PRODUCTS  POST  200  ALL  SMOKE
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   ${product_id}=  Example Example POST 200 Products Smoke
   Example Example DELETE 200 Products Smoke  ${product_id}

Example Example POST 400 Products x-originator-false Smoke
   [Documentation]  POST /api-v1/products. Assert 400. ID incorrect, empty parameters. x-originator-check == false
   [Tags]  Example  EXAMPLE  API  PRODUCTS  POST  400  ALL  SMOKE
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example POST 400 Products x-originator-false Smoke

Example Example POST 400 Products x-originator-true Smoke
   [Documentation]  POST /api-v1/products. Assert 400. ID incorrect, empty parameters. x-originator-check == true
   [Tags]  Example  EXAMPLE  API  PRODUCTS  POST  400  ALL  SMOKE
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example POST 400 Products x-originator-true Smoke

Example Example PUT 200 Products Smoke
   [Documentation]  PUT /api-v1/products. Assert 200.
   [Tags]  Example  EXAMPLE  API  PRODUCTS  PUT  200  ALL  SMOKE
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example PUT 200 Products Smoke

Example Example PUT 400 Products x-originator-false Smoke
   [Documentation]  PUT /api-v1/products. Assert 400. All IDs incorrect. x-originator-check == false
   [Tags]  Example  EXAMPLE  API  PRODUCTS  PUT  400  ALL  SMOKE
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example PUT 400 Products x-originator-false Smoke

Example Example PUT 400 Products x-originator-true Smoke
   [Documentation]  PUT /api-v1/products. Assert 400. All IDs incorrect. x-originator-check == true
   [Tags]  Example  EXAMPLE  API  PRODUCTS  PUT  400  ALL  SMOKE
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example PUT 400 Products x-originator-true Smoke

Example Example DELETE 400 Products x-originator-false Smoke
   [Documentation]  DELETE /api-v1/products. Assert 400. x-originator-check == false
   [Tags]  Example  EXAMPLE  API  PRODUCTS  DELETE  400  ALL  SMOKE
   Create Session by URL    ${EXAMPLE_URL}
   Example Example Get Bearer token
   Create Session by URL    ${EXAMPLE_URL}
   Example Example DELETE 400 Products x-originator-false Smoke


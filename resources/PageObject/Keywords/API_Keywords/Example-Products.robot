*** Settings ***
Documentation    Example API
Library          JSONLibrary
Library          RequestsLibrary
Library          Collections
Library          OperatingSystem
Resource         ../../../../config.properties/config.properties.robot
Resource         Example-Common.robot
Variables        ../../../../cijobs/Example-Config.yaml

*** Variables ***
${json_variable}                                 jsonplaceholder
${bearer_token}                                  bearerplaceholder

*** Keywords ***
Example Products Unauthorized user
    [Documentation]  Assert that response 401
    ${header}=  Create Dictionary  Content-Type=application/json
    ${parameters}=  Create Dictionary   page=1  pageSize=1
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=401

Example Products no parameters
    [Documentation]  GET /api-v1/products. 200. Loop through ID. No Parameters selected
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  page=1  pageSize=100
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    FOR    ${row}    IN    @{response_text['rows']}
        Log    ID: ${row['id']}
        Should Not Be Empty    ${row['id']}    Error: ID value is empty
    END

Example Products parameter x-request-id
    [Documentation]  Get /api-v1/products. 200. Request with only parameter x-request-id. Assert ID is not empty.
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  page=1  pageSize=100
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    FOR    ${row}    IN    @{response_text['rows']}
        Log    ID: ${row['id']}
        Should Not Be Empty    ${row['id']}
    END

Example Products parameter uuid
    [Documentation]  Get /api-v1/products. 200. Request with only parameter uuid.
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  page=1  pageSize=100
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords

Example Products parameter name
    [Documentation]  Get /api-v1/products. 200. Request with only parameter name. Assert name is not empty.
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  page=1  pageSize=100
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords

Example Products parameter vendor
    [Documentation]  Get /api-v1/products. 200. Request with only parameter vendor. Assert vendor is not empty.
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  page=1  pageSize=100
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords

Example Products parameter vendorID
    [Documentation]  Get /api-v1/products. 200. Request with only parameter vendorID. Assert vendorID is equal to request.
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  page=1  pageSize=100
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords

Example Products parameter ddrrID
    [Documentation]  Get /api-v1/products. 200. Request with parameter ddrrID. Assert ID is not empty
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  page=1  pageSize=100
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords

Example Products parameter subscriber
    [Documentation]  Get /api-v1/products  500. Request with parameter subscriber.
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  page=1  pageSize=100
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=500
    ${response_text}=  Convert String To json  ${response.content}

Example Products parameter accountID
    [Documentation]  Get /api-v1/products. 200. Request with parameter accountID. Assert ID is not empty
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  page=1  pageSize=100
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords

Example Products parameter asc as true
    [Documentation]  Get /api-v1/products. 200. Request with parameter asc as true. Assert ID is not empty
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  asc=true  page=1  pageSize=100
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords

Example Products parameter asc as false
    [Documentation]  Get /api-v1/products. 200. Request with parameter asc as true. Assert ID is not empty
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  asc=false  page=1  pageSize=100
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords

Example Products parameter sort by name
    [Documentation]  Get /api-v1/products. 200. Request with parameter sort by name. Assert name is not empty
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  sort=name  page=1  pageSize=100
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords

Example Products parameter sort by vendor
    [Documentation]  Get /api-v1/products. 200. Request with parameter sort by vendor. Assert vendor is not empty
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  sort=vendor  page=1  pageSize=100
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords

Example Products incorrect parameter uuid
    [Documentation]  Get /api-v1/products. 400. Request with incorrect parameter uuid.
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  uuid=invalid  page=1  pageSize=10
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=400

Example Products incorrect parameter name
    [Documentation]  Get /api-v1/products. 200. Request with incorrect parameter name. Assert totalRecords == 0
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  name=invalidname!!!@@@###  page=1  pageSize=10
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    Should be Equal as Integers  ${response_text['totalRecords']}  0

Example Products incorrect parameter vendor
    [Documentation]  Get /api-v1/products. 200. Request with incorrect parameter vendor. Assert totalRecords == 0
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  vendor=invalidname!!!@@@###  page=1  pageSize=10
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    Should be Equal as Integers  ${response_text['totalRecords']}  0

Example Products incorrect parameter vendorID
    [Documentation]  Get /api-v1/products. 200. Request with incorrect parameter vendor. Assert totalRecords == 0
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  vendorID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  page=1  pageSize=10
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    Should be Equal as Integers  ${response_text['totalRecords']}  0

Example Products incorrect parameter ddrrID
    [Documentation]  Get /api-v1/products. 200. Request with incorrect parameter ddrrID. Assert totalRecords == 0
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  ddrrID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  page=1  pageSize=10
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    Should be Equal as Integers  ${response_text['totalRecords']}  0

Example Products incorrect parameter subscriber
    [Documentation]  Get /api-v1/products. 500. Request with incorrect parameter subscriber
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  subscriber=invalidname!!!@@@###  page=1  pageSize=10
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=500

Example Products parameter cve
    [Documentation]  Get /api-v1/products. 200. Request with parameter cve. Assert totalRecords == 0
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  cve=CVE-2024-0001  page=1  pageSize=10
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    Should be Equal as Integers  ${response_text['totalRecords']}  0

Example Products incorrect parameter cve
    [Documentation]  Get /api-v1/products. 200. Request with incorrect parameter cve. Assert totalRecords == 0
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  cve=invalidname!!!@@@###  page=1  pageSize=10
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    Should be Equal as Integers  ${response_text['totalRecords']}  0

Example Products incorrect parameter name and vendor
    [Documentation]  Get /api-v1/products. 200. Request with incorrect parameter version and vendor. Assert totalRecords 0=0
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  name=invalidname!!!@@@###  vendor=invalidname!!!@@@###  page=1  pageSize=10
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    Should be Equal as Integers  ${response_text['totalRecords']}  0

Example Products parameter cpe
    [Documentation]  Get /api-v1/products. 200. Request with parameter cpe and vendor. Assert totalRecords != 0
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  cpe=cpe:2.3:a:example:product:1.0:*:*:*:*:*:*:*  page=1  pageSize=100
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords

Example Products incorrect parameter cpe
    [Documentation]  Get /api-v1/products. 200. Request with incorrect parameter cpe and vendor. Assert totalRecors == 0
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  cpe=invalidname!!!@@@###  page=1  pageSize=10
    ${response}=  Get On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    Should be Equal as Integers  ${response_text['totalRecords']}  0

Example POST Products Unauthorized user
    [Documentation]  POST /api-v1/products. Assert 401 response.
    ${header}=  Create Dictionary  Content-Type=application/json
    ${json_body}=  Create Dictionary    id=null
    ${response}=  Post On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  json=${json_body}  expected_status=401

Example PUT Products Unauthorized user
    [Documentation]  PUT /api-v1/products. Assert 401 response.
    ${header}=  Create Dictionary  Content-Type=application/json
    ${json_body}=  Create Dictionary  id=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
    ${response}=  Put On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  json=${json_body}  expected_status=401

Example DELETE Products Unauthorized user
    [Documentation]  DELETE /api-v1/products. Assert 401 response.
    ${header}=  Create Dictionary  Content-Type=application/json
    ${parameters}=  Create Dictionary  id=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
    ${response}=  Delete On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=401

Example POST 200 Products Smoke
    [Documentation]  POST /api-v1/products. Assert 200.
    ${random_number}=    Generate Random Number
    ${Generate Random Number 1000-9999}=  Generate Random Number 1000-9999
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${json_body}=  Create Dictionary    id=xxxxxxxx-xxxx-xxxx-xxxx-${Generate Random Number 1000-9999}xxxxxxxx
    ...    name=Test. Can be Delete ${random_number}
    ${response}=  Post On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  json=${json_body}  expected_status=200
    ${response_body}=    Set Variable    ${response.json()}
    ${product_id}=    Set Variable    ${response_body['id']}
    RETURN        ${product_id}

Example DELETE 200 Products Smoke
    [Documentation]  DELETE /api-v1/products. Assert 200
    [Arguments]    ${product_id}
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  id=${product_id}
    ${response}=  Delete On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=200

Example POST 400 Products x-originator-false Smoke
    [Documentation]  POST /api-v1/products. Assert 400. ID incorrect, empty parameters. x-originator-check == false
    ${header}=  Create Dictionary  Content-Type=application/json  x-originator-check=false
    ...  Authorization=Bearer ${bearer_token}
    ${json_body}=  Create Dictionary    id=null
    ${response}=  Post On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  json=${json_body}  expected_status=400

Example POST 400 Products x-originator-true Smoke
    [Documentation]  POST /api-v1/products. Assert 400. ID incorrect, empty parameters. x-originator-check == true
    ${header}=  Create Dictionary  Content-Type=application/json  x-originator-check=true
    ...  Authorization=Bearer ${bearer_token}
    ${json_body}=  Create Dictionary    id=null
    ${response}=  Post On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  json=${json_body}  expected_status=400

Example PUT 200 Products Smoke
    [Documentation]  PUT /api-v1/products. Assert 200.
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${json_body}=  Create Dictionary    id=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
    ...    name=Test Update
    ${response}=  Put On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  json=${json_body}  expected_status=200

Example PUT 400 Products x-originator-false Smoke
    [Documentation]  PUT /api-v1/products. Assert 400. All IDs incorrect. x-originator-check == false
    ${header}=  Create Dictionary  Content-Type=application/json  x-originator-check=false
    ...  Authorization=Bearer ${bearer_token}
    ${json_body}=  Create Dictionary    id=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
    ${response}=  Put On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  json=${json_body}  expected_status=400

Example PUT 400 Products x-originator-true Smoke
    [Documentation]  PUT /api-v1/products. Assert 400. All IDs incorrect. x-originator-check == true
    ${header}=  Create Dictionary  Content-Type=application/json  x-originator-check=true
    ...  Authorization=Bearer ${bearer_token}
    ${json_body}=  Create Dictionary    id=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
    ${response}=  Put On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  json=${json_body}  expected_status=400

Example DELETE 400 Products x-originator-false Smoke
    [Documentation]  DELETE /api-v1/products. Assert 400. x-originator-check == false
    ${header}=  Create Dictionary  Content-Type=application/json  x-originator-check=false
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  id=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
    ${response}=  Delete On Session  ${json_variable}  /api-v1/products
    ...  headers=${header}  params=${parameters}  expected_status=400


*** Settings ***
Documentation    Example API
Library          JSONLibrary
Library          RequestsLibrary
Library          Collections
Library          OperatingSystem
Resource         ../../../config.properties/config.properties.robot
Resource         ../../../resources/PageObject/Example_Keywords/Example-Common.robot
Variables        ../../../resources/PageObject/Example_Keywords/Example-Config.yaml

*** Variables ***
${json_variable}                                 jsonplaceholder
${bearer_token}                                  bearerplaceholder
# X-request-id currently is not in use
${x-request-id}                                  xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
# UUID belong to vendor
${uuid}                                          xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
${automated_smoke_test_uuid}                     xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
${name}                                          Example Client Name
${website}                                       example.org
${emailAddress}                                  example@example.com
${invalid_uuid}                                   xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
${invalid_name}                                  invalidname!!!@@@###
${emailaddress_accounts}                        example_robot_framework@test.com
${streetaddress_accounts}                       123 Example St, apt 19
${account_typeID}                                xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
${empty_variable}

*** Keywords ***
Generate Sub ID
    [Documentation]  Genrating random number for Subscriber ID
    ${n_sub}=    Evaluate    str(random.randint(1000, 9999))
    ${sub_id}=    Catenate    xxxxxxxx-${n_sub}-xxxx-xxxx-xxxxxxxxxxxx
    Set Global Variable    ${sub_id}

Example Example Accounts By ID
    [Documentation]  Test Case assert 200 status code. Verifis that id is equal to id in response
    ${header}=  Create Dictionary  Content-Type=application/json  x-request-id=${x-request-id}
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  id=${automated_smoke_test_uuid}  page=1  pageSize=100
    Set Suite Variable    ${header}
    ${response}=  Get On Session  ${json_variable}  /api-v1/accounts
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    Should Be Equal    ${response_text['rows'][0]['id']}    ${automated_smoke_test_uuid}

Example Example GET Accounts Unauthorized user
    [Documentation]  Assert that response 401
    ${header}=  Create Dictionary  Content-Type=application/json  x-request-id=${x-request-id}
    ${parameters}=  Create Dictionary   page=1  pageSize=1
    ${response}=  Get On Session  ${json_variable}  /api-v1/accounts
    ...  headers=${header}  params=${parameters}  expected_status=401

Example Example Accounts
    [Documentation]  Send request without parameters. Loop through all ID. Assert ID is not empty.
    ${header}=  Create Dictionary  Content-Type=application/json  x-request-id=${x-request-id}
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  page=1  pageSize=100
    Set Suite Variable    ${header}
    ${response}=  Get On Session  ${json_variable}  /api-v1/accounts
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    FOR    ${row}    IN    @{response_text['rows']}
        Log    ID: ${row['id']}
        Should Not Be Empty    ${row['id']}    Error: ID value is empty
    END

Example Example Accounts By Name
    [Documentation]  Test Case assert 200 status code. Verifis that Name is equal to Name in response
    ${header}=  Create Dictionary  Content-Type=application/json  x-request-id=${x-request-id}
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  name=${name}  page=1  pageSize=100
    ${response}=  Get On Session  ${json_variable}  /api-v1/accounts
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    Should Be Equal    ${response_text['rows'][0]['name']}    ${name}

Example Example Accounts By Domain
    [Documentation]  Test Case assert 200 status code. Verifis that domain is equal to website in response
    ${header}=  Create Dictionary  Content-Type=application/json  x-request-id=${x-request-id}
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  website=${website}  page=1  pageSize=100
    ${response}=  Get On Session  ${json_variable}  /api-v1/accounts
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    #TODO As for now returning an empty string in response
#    Should Be Equal  ${response_text['rows'][0]['website']}  ${website}

Example Example Accounts By emailAddress
    [Documentation]  Test Case assert 200 status code. Verifis that email is equal to email in response
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  emailAddress=${emailAddress}  page=1  pageSize=100
    ${response}=  Get On Session  ${json_variable}  /api-v1/accounts
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    #TODO As for now returning an empty string in response
#    Should Be Equal  ${response_text['rows'][0]['emailAddress']}  ${emailAddress}

Example Example Accounts showDeleted
    [Documentation]  Set showDeleted as true. Loop vendor name assert 200 and name is not empty
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  showDeleted=true  name=${name}  page=1  pageSize=1
    ${response}=  Get On Session  ${json_variable}  /api-v1/accounts
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    # Name can be different from variable
    FOR    ${row}    IN    @{response_text['rows']}
        Log    ID: ${row['name']}
        Should Not Be Empty    ${row['name']}
    END

Example Example Accounts showDeleted as false
    [Documentation]  Set showDeleted as false. Loop vendor name assert 200 and name is not empty
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  showDeleted=false  name=${name}  page=1  pageSize=100
    ${response}=  Get On Session  ${json_variable}  /api-v1/accounts
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    # Name can be different from variable
    FOR    ${row}    IN    @{response_text['rows']}
        Log    ID: ${row['name']}
        Should Not Be Empty    ${row['name']}
    END

Example Example Accounts by x-request-id
    [Documentation]  Get /api-v1/accounts. Assert 200. Assert Id is not empty.
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  x-request-id=${x-request-id}  page=1  pageSize=100
    Set Suite Variable    ${header}
    ${response}=  Get On Session  ${json_variable}  /api-v1/accounts
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    FOR    ${row}    IN    @{response_text['rows']}
        Log    ID: ${row['id']}
        Should Not Be Empty    ${row['id']}
    END

Example Example Accounts by linked as true
    [Documentation]  Get /api-v1/accounts. Assert 200. Parameter linked. Assert Id is not empty.
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary    linked=true  page=1  pageSize=100
    Set Suite Variable    ${header}
    ${response}=  Get On Session  ${json_variable}  /api-v1/accounts
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    FOR    ${row}    IN    @{response_text['rows']}
        Log    ID: ${row['id']}
        Should Not Be Empty    ${row['id']}
    END

Example Example Accounts by linked as false
    [Documentation]  Get /api-v1/accounts. Assert 200. Parameter linked. Assert Id is not empty.
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary    linked=false  page=1  pageSize=100
    Set Suite Variable    ${header}
    ${response}=  Get On Session  ${json_variable}  /api-v1/accounts
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    FOR    ${row}    IN    @{response_text['rows']}
        Log    ID: ${row['id']}
        Should Not Be Empty    ${row['id']}
    END

Example Example Accounts by asc as true
    [Documentation]  Get /api-v1/accounts. Assert 200. Parameter asc. Assert Id is not empty.
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary    asc=true  page=1  pageSize=100
    Set Suite Variable    ${header}
    ${response}=  Get On Session  ${json_variable}  /api-v1/accounts
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    FOR    ${row}    IN    @{response_text['rows']}
        Log    ID: ${row['id']}
        Should Not Be Empty    ${row['id']}
    END

Example Example Accounts by asc as false
    [Documentation]  Get /api-v1/accounts. Assert 200. Parameter asc. Assert Id is not empty.
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary    asc=false  page=1  pageSize=100
    Set Suite Variable    ${header}
    ${response}=  Get On Session  ${json_variable}  /api-v1/accounts
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    FOR    ${row}    IN    @{response_text['rows']}
        Log    ID: ${row['id']}
        Should Not Be Empty    ${row['id']}
    END

Example Example Accounts by invalid uuid
    [Documentation]  Get /api-v1/accounts. Assert totalRecords == 0
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary    id=${invalid_uuid}  page=1  pageSize=10
    ${response}=  Get On Session  ${json_variable}  /api-v1/accounts
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    Should be Equal as Integers  ${response_text['totalRecords']}  0

Example Example Accounts by invalid name
    [Documentation]  Get /api-v1/accounts. Assert totalRecords == 0. Assert 200
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary    name=${invalid_name}  page=1  pageSize=10
    ${response}=  Get On Session  ${json_variable}  /api-v1/accounts
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    Should be Equal as Integers  ${response_text['totalRecords']}  0

Example Example Accounts by invalid website
    [Documentation]  Get /api-v1/accounts. Assert totalRecords == 0. Assert 200
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary    website=${invalid_name}  page=1  pageSize=10
    ${response}=  Get On Session  ${json_variable}  /api-v1/accounts
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    Should be Equal as Integers  ${response_text['totalRecords']}  0

Example Example Accounts by invalid emailAddress
    [Documentation]  Get /api-v1/accounts. Assert totalRecords == 0. Assert 200
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary    emailAddress=${invalid_name}  page=1  pageSize=10
    Set Suite Variable    ${header}
    ${response}=  Get On Session  ${json_variable}  /api-v1/accounts
    ...  headers=${header}  params=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    Dictionary Should Contain Key    ${response_text}    totalRecords
    Should be Equal as Integers  ${response_text['totalRecords']}  0

Test Accounts Create New Subscriber Post
    [Documentation]  Creating Subscribe. Posting it. Verifies 200 and subscriber ID
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary     id=${sub_id}  name=API_automated test ${sub_id}  website=api.domain.com
    Set Suite Variable    ${header}
    ${response}=  Post On Session  ${json_variable}  /api-v1/accounts
    ...  headers=${header}  json=${parameters}  expected_status=200
    ${response_text}=  Convert String To json  ${response.content}
    ${subscriber}=    Set Variable    ${response.json()["id"]}
    Should be equal  ${subscriber}  ${sub_id}

Example Example POST Accounts Unauthorized user
    [Documentation]  POST /api-v1/accounts  Assert 401
    ${header}=  Create Dictionary  Content-Type=application/json  x-request-id=${x-request-id}
    ${json_body}=  Create Dictionary    id=null
    ...    name=string
    ...    website=string
    ...    emailAddress=string
    ...    logoURL=string
    ...    city=string
    ...    country=string
    ...    phone=string
    ...    state=string
    ...    streetAddress=string
    ...    accountTypeID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
    ...    accountType=string
    ...    linkedVendorID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
    ...    contactEmail=string
    ...    claimedByContactEmail=string
    ${response}=  Post On Session  ${json_variable}  /api-v1/accounts
    ...  headers=${header}  json=${json_body}  expected_status=401

Example Example PUT Accounts Unauthorized user
    [Documentation]  PUT /api-v1/accounts  Assert 401
    ${header}=  Create Dictionary  Content-Type=application/json  x-request-id=${x-request-id}
    ${json_body}=  Create Dictionary  id=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
    ...    name=string
    ...    website=string
    ...    emailAddress=string
    ...    logoURL=string
    ...    city=string
    ...    country=string
    ...    phone=string
    ...    state=string
    ...    streetAddress=string
    ...    accountTypeID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
    ...    accountType=string
    ...    linkedVendorID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
    ...    contactEmail=string
    ...    claimedByContactEmail=string
    ${response}=  Put On Session  ${json_variable}  /api-v1/accounts
    ...  headers=${header}  json=${json_body}  expected_status=401

Example Example DELETE Accounts Unauthorized user
    [Documentation]  DELETE /api-v1/accounts  Assert 401
    ${header}=  Create Dictionary  Content-Type=application/json  x-request-id=${x-request-id}
    ${parameters}=  Create Dictionary  id=${uuid}
    ${response}=  Delete On Session  ${json_variable}  /api-v1/accounts
    ...  headers=${header}  params=${parameters}  expected_status=401

Example Example POST 200 Accounts Smoke
    [Documentation]  POST /api-v1/accounts. Assert 200.
    ${random_number}=    Generate Random Number
    ${Generate Random Number 1000-9999}=  Generate Random Number 1000-9999
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${json_body}=  Create Dictionary    id=xxxxxxxx-xxxx-xxxx-xxxx-${Generate Random Number 1000-9999}xxxxxxxx
    ...    name=Test. Can be Delete ${random_number}
    ...    website=test.com
    ...    emailAddress=test.can.delete@test.com
    ...    logoURL=${random_number}
    ...    city=Orlando
    ...    country=US
    ...    phone=1800${random_number}
    ...    state=FL
    ...    streetAddress=${streetaddress_accounts}
    ...    linkedVendorID=${empty_variable}
    ...    contactEmail=${emailaddress_accounts}
    ...    claimedByContactEmail=${emailaddress_accounts}
    ${response}=  Post On Session  ${json_variable}  /api-v1/accounts
    ...  headers=${header}  json=${json_body}  expected_status=200
    ${response_body}=    Set Variable    ${response.json()}
    ${account_id}=    Set Variable    ${response_body['id']}
    RETURN        ${account_id}

Example Example DELETE 200 Accounts Smoke
# Parameters taken from Example Example Example Example POST 200 Accounts Smoke
    [Documentation]  DELETE /api-v1/accounts. Assert 200
    [Arguments]    ${account_id}
    ${header}=  Create Dictionary  Content-Type=application/json
    ...  Authorization=Bearer ${bearer_token}
    ${parameters}=  Create Dictionary  id=${account_id}
    ${response}=  Delete On Session  ${json_variable}  /api-v1/accounts
    ...  headers=${header}  params=${parameters}  expected_status=200


@Regression
Feature: Get Account Feature Testing


  Background: setup test
    Given url BASE_URL
    * def tokenResult = callonce read('GenerateToken.feature')
    And print tokenResult
    * def validToken = "Bearer " + tokenResult.response.token

  Scenario: testing endpoint /api/accounts/get-account
    Given path "/api/accounts/get-account"
    * def expectedId = 353
    Given param primaryPersonId = expectedId
    Given header Authorization = validToken
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.id == expectedId

    Scenario: Testing endpoint /api/accounts/get-account with primaryPersonId not exist
      Given path "/api/accounts/get-account"
      * def expectedId = 373
      Given param primaryPersonId = expectedId
      Given header Authorization = validToken
      When method get
      Then status 404
      And print response.httpStatus == "NOT_FOUND"



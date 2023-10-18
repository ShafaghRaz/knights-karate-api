Feature: Account code Testing


  Background: setup test
    Given url "https://qa.insurance-api.tekschool-students.com"
  Scenario: Validate /api/accounts/get-account
    Given path "/api/token"
    Given request {"username" : "supervisor" , "password" : "tek_supervisor"}
    When method post
    Then status 200
    And print response
    * def validToken = "Bearer " + response.token
    Given path "/api/accounts/get-account"
    And header Authorization = validToken
    And param primaryPersonId == response.primaryPersonId
    When method get
    Then status 200
    And print response



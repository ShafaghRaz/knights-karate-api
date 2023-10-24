@Regression
Feature: Security token verify API calls

  Background: Setup test
  Given url BASE_URL


  Scenario: Send Request to /api/token/verify
    And path "/api/token"
    And request {"username" : "supervisor" , "password" : "tek_supervisor"}
    When method post
    Then status 200
    And print response
    And path "/api/token/verify"
    And param username = "supervisor"
    And param token = response.token
    When method get
    Then status 200
    And print response
    And assert response.message == "Token is valid"

    Scenario: Send valid username invalid token to /api/token/verify
      And path "/api/token/verify"
      And param username = "supervisor"
      And param token = "Wrong Token"
      When method get
      Then print response
      And status 400
      And assert response.errorMessage == "Token Expired or Invalid Token"

      Scenario: Send valid token with invalid username to /api/token/verify
        And path "/api/token"
        And request {"username" : "supervisor" , "password" : "tek_supervisor"}
        When method post
        Then status 200
        And print response
        And path "/api/token/verify"
        And param username = "supervisorWrong"
        And param token = response.token
        When method get
        Then status 400
        And print response
        And assert response.errorMessage == "Wrong Username send along with Token"





@Regression
Feature: Plan code Testing


  Background: setup test
    Given url BASE_URL
  Scenario: Validate /api/plans/get-all-plan-code
    Given path "/api/token"
    Given request {"username" : "supervisor" , "password" : "tek_supervisor"}
    When method post
    Then status 200
    And print response
    * def validToken = "Bearer " + response.token
    Given path "/api/plans/get-all-plan-code"
    And header Authorization = validToken
    When method get
    Then status 200
    And print response
    And assert response[0].planExpired == false
    And assert response[1].planExpired == false
    And assert response[2].planExpired == false
    And assert response[3].planExpired == false


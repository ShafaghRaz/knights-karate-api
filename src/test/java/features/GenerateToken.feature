@Regression
Feature: Generate Token Feature


  Scenario: Generate valid token
    Given url  BASE_URL
    Given path "/api/token"
    Given request {"username" : "supervisor" , "password" : "tek_supervisor"}
    When method post
    Then status 200
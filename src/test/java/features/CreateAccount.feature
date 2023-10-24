@Regression
Feature: Create Account Testing

  Background: setup test
    Given url  BASE_URL
    * def tokenResult = callonce read('GenerateToken.feature')
    And print tokenResult
    * def validToken = "Bearer " + tokenResult.response.token

  Scenario: Add account to primary account
    Given path "/api/accounts/add-primary-account"
    And request
    """
    {
  "email": "Shay.Raz4567@yahoo.com",
  "firstName": "Shay",
  "lastName": "Raz",
  "title": "Mrs",
  "gender": "FEMALE",
  "maritalStatus": "MARRIED",
  "employmentStatus": "Retail",
  "dateOfBirth": "2000-12-12",
    }
    """
    When method post
    Then status 201
    And print response
    And assert response.email == "Shay.Raz4567@yahoo.com"
    * def createdAccountId = response.id
    Given path "/api/accounts/delete-account"
    And param primaryPersonId = createdAccountId
    And header Authorization = validToken
    When method delete
    Then status 200
    And print response
    And match response contains {"message" : "Account Successfully deleted" , "status" : true}

  Scenario: Create account with existing email /api/accounts/add-primary-account validate response
    Given path "/api/accounts/add-primary-account"
    * def email = "Shay.Raz_98761138@yahoo.com"
    And request
    """
    {
  "email": "#(email)",
  "firstName": "Shay",
  "lastName": "Raz",
  "title": "Mrs",
  "gender": "FEMALE",
  "maritalStatus": "MARRIED",
  "employmentStatus": "Retail",
  "dateOfBirth": "2000-12-12",
    }
    """
    When method post
    Then print response
    Then status 201
    * def createdAccountId = response.id
    Given path "/api/accounts/add-primary-account"
    And request
    """
    {
  "email": "#(email)",
  "firstName": "Shay",
  "lastName": "Raz",
  "title": "Mrs",
  "gender": "FEMALE",
  "maritalStatus": "MARRIED",
  "employmentStatus": "Retail",
  "dateOfBirth": "2000-12-12",
    }
    """
    When method post
    Then print response
    Then status 400
    And assert response.errorMessage == "Account with email " + email + " is exist"
    Given path "/api/accounts/delete-account"
    And param primaryPersonId = createdAccountId
    And header Authorization = validToken
    When method delete
    Then status 200
    And print response
    And match response contains {"message" :  "Account Successfully deleted" , "status" :  true}
@Regression
Feature: End to end account creation

  Background: Setup test to get token
    Given url BASE_URL
    * def tokenResult = callonce read('GenerateToken.feature')
    * def token = "Bearer " + tokenResult.response.token

  @End2End
  Scenario: Create Account end to end.
    Given path "/api/accounts/add-primary-account"
    * def data = Java.type('Data.DataGenerator')
    * def emailData = data.getEmail()
    And request
    """
    { "email": "#(emailData)",
  "firstName": "Shay",
  "lastName": "Raz",
  "title": "Mrs",
  "gender": "FEMALE",
  "maritalStatus": "MARRIED",
  "employmentStatus": "Retail",
  "dateOfBirth": "2000-12-12",
    }
    """
    And header Authorization = token
    When method post
    Then status 201
    And assert response.email == emailData
    * def createAccountId  = response.id
    Given path "/api/accounts/add-account-address"
    And param primaryPersonId = createAccountId
    And header Authorization = token
    And request
    """
    {"addressType": "home",
  "addressLine1": "1 main st SE",
  "city": "Dallas",
  "state": "TX",
  "postalCode": "20987",
  "countryCode": "001"
    }
    """
    When method post
    Then status 201
    And assert response.postalCode == "20987"
    Given path "/api/accounts/add-account-car"
    And param primaryPersonId = createAccountId
    And header Authorization = token
    And request
     """
    {
    "make": "BMW",
    "model": "X6",
    "year": "2020",
    "licensePlate": "hello1"
    }
    """
    When method post
    Then status 201
    And assert response.make == "BMW"
    Given path "/api/accounts/add-account-phone"
    And param primaryPersonId = createAccountId
    And header Authorization = token
    And request
    """
    {
    "phoneNumber": "1142389076",
    "phoneExtension": "001",
    "phoneTime": "morning",
    "phoneType": "cellphone"
    }
    """
    When method post
    Then status 201
    And assert response.phoneNumber == "1142389076"
    And print createAccountId
    Given path "/api/accounts/delete-account"
    And param primaryPersonId = createAccountId
    And header Authorization = token
    When method delete
    Then status 200
    And match response == {"status": true, "httpStatus": "OK","message": "Account Successfully deleted"}






@Regression
Feature: Create Account with Random Email using java

  Background: setup test
    Given url  BASE_URL

    Scenario: Create valid account /api/accounts/add-primary-account
      Given path "/api/accounts/add-primary-account"
      * def DataGenerator = Java.type('Data.DataGenerator')
      * def autoEmail = DataGenerator.getEmail();
      * def firstName = DataGenerator.getFirstName();
      * def lastName = DataGenerator.getLastName();
      * def position = DataGenerator.getPosition();
     And request
      """
      {
  "email": "#(autoEmail)",
  "firstName": "#(firstName)",
  "lastName": "#(lastName)",
  "title": "Mrs",
  "gender": "FEMALE",
  "maritalStatus": "MARRIED",
  "employmentStatus": "#(position)",
  "dateOfBirth": "2000-12-12",
    }
      """
      When method post
      Then print response
      Then status 201
      And assert response.email == autoEmail

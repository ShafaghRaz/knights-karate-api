@Smoke
Feature: Security Token API calls

  Scenario: Send Request to /api/token
    Given url  BASE_URL
    And path "/api/token"
    And request {"username" : "supervisor" , "password" : "tek_supervisor"}
    When method post
    Then status 200


  Scenario Outline: Send Request to /api/token with wrong username
    Given url "https://qa.insurance-api.tekschool-students.com"
    And path "/api/token"
    And request {"username" : "<data_username>" , "password" : "<data_password>"}
    When method post
    And print response
    Then status <expectStatus>
    And assert response.httpStatus == "<httpStatus>"
    And assert response.errorMessage == "<errorMessage>"

    Examples:
    |data_username| data_password|expectStatus|httpStatus|errorMessage|
    |supervisorwrong|tek_supervisor|404       |NOT_FOUND |User supervisorwrong not found|
    |supervisor     |tek_supervisorwrong|400  |BAD_REQUEST|Password not matched         |

    Scenario: Send request to /api/token with wrong password
      Given url "https://qa.insurance-api.tekschool-students.com"
      And path "/api/token"
      And request
      """
      {"username" : "supervisor" ,
      "password" : "tek_supervisorwrong"}
      """
      When method post
      Then print response
      Then status 400
      And assert response.httpStatus == "BAD_REQUEST"
      And assert response.errorMessage == "Password not matched"



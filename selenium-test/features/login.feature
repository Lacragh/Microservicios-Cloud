Feature: Login Feature
  Scenario: Successful login with valid credentials
    Given the user is on the login page
    When the proceed button is displayed
    When the user logs in with valid credentials
    When a new todo item is added
    Then the todo item should be displayed in the list
  


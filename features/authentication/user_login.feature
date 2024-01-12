Feature: User Login
  As a student
  I want to register and log in using my school email and password
  So that I can upload films and view my uploaded films

  Background:
    Given an account with email "existingstudent@school.edu" and password "securepassword123"

  Scenario: Successful registration with a school email and password of sufficient length
    Given I am on the registration page
    When I fill in my email "newstudent@school.edu" and password "securepassword123"
    And I click the "submit-button" element
    Then I should be redirected to the user profile page

  Scenario: Unsuccessful registration with a non-school email
    Given I am on the registration page
    When I fill in my email "newstudent@gmail.com" and password "securepassword123"
    And I click the "submit-button" element
    Then I should see "Must use a valid school email."

  Scenario: Unsuccessful registration with password of insufficient length
    Given I am on the registration page
    When I fill in my email "newstudent@school.edu" and password "pw"
    And I click the "submit-button" element
    Then I should see "Password should be longer than 6 characters."

  Scenario: Successful login with a school email and correct password
    Given I am on the login page
    When I fill in my email "existingstudent@school.edu" and password "securepassword123"
    And I click the "Login" button
    Then I should be redirected to the user profile page

  Scenario: Unsuccessful login with incorrect password
    Given I am on the login page
    When I fill in my email "existingstudent@school.edu" and password "wrongpassword"
    And I click the "Login" button
    Then I should see "Incorrect login information"

  

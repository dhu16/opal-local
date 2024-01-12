Feature: Film Filtering
  As a logged-in student filmmaker
  I want to view a list of films I have uploaded
  So that I can easily access and manage my content

  Background: Student Films in database
  Given some schools
  And some users
      | id        | email               | school_id |
      | 1         | user@example.com    |           |
      | 2         | user2@example.com   |           |
      | 3         | nofilms@example.com |           |

  And some films
      | title         | description           | user_id |
      | Star Wars     | Opera, but in space   | 1       |
      | Solo          | Western, but in space | 1       |
  Then there are 2 movies

  Scenario: User sees most recent films
    Given I am logged in as "user@example.com"
    When I go to the home page
    And I should see 2 "recommended-slide" elements


  Scenario: User filters films by school
    Given I am logged in as "user@example.com"
    And my school is Columbia University
    When I go to the home page
    Then I should see the Filter Films By School dropdown
    When I select "columbia" from the dropdown
    And I click the "FILTER" button
    And I go to this url: /home?school=columbia&commit=FILTER
    And I should see 2 "recommended-slide" elements

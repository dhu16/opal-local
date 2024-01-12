Feature: Video Player
  As a logged-in student filmmaker
  I want to view a list of films I have uploaded
  So that I can easily access and manage my content

  Background: Student Films in database
  Given some schools
  And some users
      | id        | email               |
      | 1         | user@example.com    |
      | 2         | nofilms@example.com |

  And some films
      | id | title         | description           | user_id |
      | 1  | Star Wars     | Opera, but in space   | 1       |
  Then there are 1 movies

  Scenario: View a film
    Given I am logged in as "user@example.com"
    When I go to this url: /films/1
    Then I should see "Star Wars"
    And I should see "Opera, but in space"
    And I should see a video player

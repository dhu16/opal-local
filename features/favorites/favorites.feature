Feature: Favorites
  As a logged-in student filmmaker
  I want to save my favorite films
  So that I can revisit them later

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

  Scenario: Favorite a film
    Given I am logged in as "user@example.com"
    When I go to this url: /films/1
    And I click the "ADD TO FAVORITES" button
    And I go to this url: /users/1/favorites
    Then I should see "Star Wars"

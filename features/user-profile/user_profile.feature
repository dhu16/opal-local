Feature: User Profile
  As a logged-in student filmmaker
  I want to view other filmmakers videos
  So that I can find inspiration

  Background: Student Films in database
  Given some schools
  And some users
      | id        | email               |
      | 1         | user@example.com    |

  And some films
      | title         | description           | user_id |
      | Star Wars     | Opera, but in space   | 1       |
      | Solo          | Western, but in space | 1       |
  Then there are 2 movies

  Scenario: View list of submitted films
    Given I am logged in as "user@example.com"
    When I go to this url: /users/1
    Then I should see a "UPLOAD YOUR FILM" link
    And I should see 2 "recommended-slide" elements


  # sad path
  Scenario: A user with no films should see nothing
    Given I am logged in as "nofilms@example.com"
    When I go to this url: /users/2
    Then I should not see a "film-link" class
    And I should not see a "recommended-slide" class

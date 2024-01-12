Feature: Home Page Navigation
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
      | title         | description           | user_id |
      | Star Wars     | Opera, but in space   | 1       |
      | Solo          | Western, but in space | 1       |
  Then there are 2 movies

Scenario: User visits the home page and navigates to Profile
    Given I am logged in as "user@example.com"
    When I am on the home page and I click the "Profile" link
    Then I should be redirected to the user profile page

Scenario: User visits the home page and navigates to Favorites
    Given I am logged in as "user@example.com"
    When I am on the home page and I click the "Favorites" link
    Then I should be redirected to the favorites page
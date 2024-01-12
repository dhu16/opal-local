Feature: Comment Section
  As a logged-in student filmmaker
  I want to comment on a film
  So that I can share my opinions

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

  Scenario: Find the comment section
    Given I am logged in as "nofilms@example.com"
    When I go to this url: /films/1
    Then I should see a "comments-list" element

  Scenario: Post a comment
    Given I am logged in as "nofilms@example.com"
    When I go to this url: /films/1
    And I fill out "comment-input" with "This is awesome!"
    And I click the "Comment" button
    Then I should see "This is awesome" in the comment section

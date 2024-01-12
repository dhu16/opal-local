Feature: Find a list of available movies on the homepage

As a filmmaker
So that I can share my movie
I want to be able to upload it to the database

Background: Student Films in database
  Given some schools
  Given some users
    | id        | email            |
    | 1         | user@example.com |

  Given some films
    | title         | description          | user_id |
    | Star Wars     | Opera, but in space  | 1       |
    | Blade Runner  | Very rainy neo-noir  | 1       |
    | Alien         | An unwanted stowaway | 1       |
    | Indiana Jones | Profs aren't so hot  | 1       |
  And I am logged in
  Then there are 4 movies

Scenario: Open the upload page
  When I go to the upload page
  Then I see the following text fields: "Title", "Description"
  And I should see a "Upload Film" button
  And I should see a file upload

# sad path
Scenario: Filled out form partially
  When I go to the upload page
  And I fill out "Title" with "Breakfast Club"
  And I click the "Upload Film" button
  Then I should see "Missing required fields" # flash message

# sad path
Scenario: Wrong filetype
  When I go to the upload page
  * I fill out "Title" with "Breakfast Club"
  * I fill out "Description" with "Detention -> Therapy Session"
  * I attach a .txt file to "Film File:"
  * I click the "Upload Film" button
  Then I should see "Invalid filetype" # flash message

Scenario: Filled out form fully and correctly
  When I go to the upload page
  * I fill out "Title" with "Breakfast Club"
  * I fill out "Description" with "Detention -> Therapy Session"
  * I attach a .mp4 file to "Film File:"
  * I attach a .png file to "Thumbnail Image:"
  * I click the "Upload Film" button
  Then I should be redirected to the user profile page

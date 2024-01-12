# Feature: Film Submission
#   As a logged-in student filmmaker
#   I want to upload my films directly
#   So that they can be immediately available on my account page

#   Scenario: Successful film upload
#     Given I am logged in as "student@school.edu"
#     And I am on the film upload page
#     When I fill in the film details
#       | title        | Student Film 1       |
#       | description  | A short film about…  |
#       | director     | Jane Doe             |
#     And I upload a video file "film1.mp4"
#     And I click on "Upload Film"
#     Then I should see "Film uploaded successfully"
#     And "Student Film 1" should be listed on my dashboard

#   Scenario: Unsuccessful film upload when not logged in
#     Given I am on the film upload page
#     When I fill in the film details
#       | title        | Student Film 2       |
#       | description  | Another short film   |
#       | director     | John Smith           |
#     And I upload a video file "film2.mp4"
#     And I click the "Upload Film" button
#     Then I should see "You must be logged in to upload films"

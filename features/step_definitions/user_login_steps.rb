Given /an account with email "(.+?)" and password "(.+?)"$/ do |email, pw|
  new_user = User.new(email: email)
  new_user.password = pw
  new_user.save
end

Given /I am on the (.+) page/ do |page_name|
  visit path_to(page_name)
end

When /I fill in my email "(.+)" and password "(.+)"/ do |email, pw|
  fill_in 'Email', with: email
  fill_in 'Password', with: pw
end

Then /I should be redirected to the (.+) page/ do |page_name|
  expect(page).to have_current_path(regex_for_path(page_name), ignore_query: true)
end

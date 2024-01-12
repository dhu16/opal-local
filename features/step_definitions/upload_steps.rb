# --- Given --- (prepare background for all tests)
Given /some users/ do |table|
  User.delete_all
  User.from_table(table)
end

Given /some schools/ do
  School.delete_all
  @test_school = School.test_fixtures
end

Given /some films/ do |table|
  Film.delete_all
  Film.from_table(table)
end

Given /I am logged in$/ do
  step "Given I am logged in as \"user@example.com\""
end

Given /I am logged in as "(.+)"/ do |email|
  unless User.exists?(email: email)
    step "Given an account with email \"#{email}\" and password \"123456\""
  end

  step "Given I am on the login page"
  step "When I fill in my email \"#{email}\" and password \"123456\""
  step "And I click the \"Login\" button"
end

And /my school is Columbia University/ do
  User.find_by(email: "user@example.com").update(school: @test_school)
  puts  User.find_by(email: "user@example.com").school_id
end

# --- When ---

When /I fill out "(.+?)" with "(.+?)"/ do |field_label, value|
  fill_in field_label, with: value
end

When /I click the "(.+?)" button/ do |text|
  find_button(text).click
end

When /I click the "(.+?)" element/ do |element|
  f = find(".#{element}", match: :first)
  f.click
end

When /I go to the (.+) page/ do |page_name|
  visit path_to(page_name)
end

When /I go to this url: (.+)/ do |url|
  visit url
end

When /I attach a (.+?) file to "(.+?)"/ do |file_type, label|
  sample_file = nil
  case file_type
  when '.mp4'
    sample_file = 'spec/fixtures/files/sample.mp4'
  when '.txt'
    sample_file = 'spec/fixtures/files/sample.txt'
  when '.png'
    sample_file = 'spec/fixtures/files/sample.png'
  else
    throw Exception("Did not recognize file type #{file_type}")
  end

  attach_file(label, sample_file)
end

# --- Then ---

Then /there are (.*) movies/ do |num|
  num = Integer(num)
  expect(Film.count).to eq num
end

Then /I see the following text fields: (.*)/ do |fields|
  fields.scan(/"(.+?)"/) { |item| expect { find_field(item[0]) }.not_to raise_error }
end

Then /I should see a "(.+)" button/ do |text|
  expect { find_button(text) }.not_to raise_error
end

Then /I should see a "(.+)" link/ do |text|
  expect(first('a', text: text)).not_to be_nil
end

Then /I should see a file upload/ do
  find('input', match: :first) { |elem| elem['type'] == 'file' }
end

Then /I should see a "(.+?)" element/ do |element|
  find(".#{element}", match: :first)
end

Then /I should see (\d+) "(.+?)" elements/ do |num, element|
  find(".#{element}", match: :first)
  expect(all(".#{element}").count).to eq num
end

Then /I should see "(.+)"/ do |text|
  expect(page.body).to include CGI.escapeHTML(text)
end

Then /I should see a video player/ do
  find("video", match: :first)
end

Then /Debug/ do
  save_and_open_page
end

Then /I should( not)? see a "(.+)" class/ do |negate, clazz|
  # Look for a CSS class. Raises if not there
  matches = page.all(".#{clazz}")
  if negate
    expect(matches).to be_empty
  else
    expect(matches).not_to be_empty
  end
end

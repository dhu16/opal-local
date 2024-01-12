When /I am on the (.+)  page and I click the "(.+)" link/ do |page_name, text|
    visit path_to(page_name)
    find('.nav-profile-div .nav-link.w-nav-link', text: text, visible: true).click
end

Then(/^I should see the Filter Films By School dropdown$/) do
    # Assuming you have a unique identifier for the dropdown, like its label or a CSS class
    expect(page).to have_select('Filter Films By School')
end

When /I select "(.+)" from the dropdown/ do |text|
    select(text, :from => 'Filter Films By School')
end

Then /the page should be refreshed to the (.+?) page/ do |page_name|
    expect(page).to have_current_path(path_to(page_name))
end
  

  
  
  
  
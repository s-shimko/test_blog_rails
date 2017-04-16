include MethodsLib

Given(/^visit main page$/) do
  visit "http://localhost:3000/"
end

Given(/^visit main page with login "([^"]*)" and pass "([^"]*)"$/) do |login, pass|
  visit "http://#{login}:#{pass}@localhost:3000/"
end

Given(/^visit address "(.*)" with login "([^"]*)" and pass "([^"]*)"$/) do |address, login, pass|
  visit "http://#{login}:#{pass}@#{address}"
end

Then(/^verify text "(.*)" is present$/) do |text|
  expect(page).to have_content(text)
end

When(/^click 'My Blog' link$/) do
  find("a[href='/articles']").click
  wait_until { has_css?("a[href='/articles/new']") }
end

When(/^click 'New article' link$/) do
  find("a[href='/articles/new']").click
  wait_until { has_css?("#new_article") }
end

When(/^click (\d+) 'Show' link$/) do |arg|
  all(:xpath, ".//a[contains(., 'Show')]")[arg.to_i - 1].click
  wait_until { has_css?("p>strong") }
end

When(/^click 'Back' link$/) do
  find(:xpath, ".//a[.='Back']").click
  wait_until { has_css?("a[href='/articles/new']") }
end


When(/^create @random_number variable$/) do
  @random_number = rand(9999).to_s
  puts "Random number: #{@random_number}"
end

When(/^fill 'Title' form with prefix from GLOBAL_HASH "(.*)"$/) do |hash_key|
  random_title = $GLOBAL_HASH[hash_key] + "_title"
  fill_in('Title', :with => random_title)
  puts "Title: #{random_title}"
end

When(/^fill 'Text' form with prefix from GLOBAL_HASH "(.*)"$/) do |hash_key|
  random_text = $GLOBAL_HASH[hash_key] + "_text"
  fill_in('Text', :with => random_text)
  puts "Text: #{random_text}"
end

When(/^click 'Create Article' button$/) do
  find("input[type='submit']").click
  wait_until { has_css?("p>strong") }
end

Then(/^verify that article created with prefix from GLOBAL_HASH "(.*)"$/) do |hash_key|
  expect(page).to have_selector 'p', :text => "#{$GLOBAL_HASH[hash_key]}_title"
  expect(page).to have_selector 'p', :text => "#{$GLOBAL_HASH[hash_key]}_text"

  find(:xpath, ".//a[.='Back']").click
  wait_until { has_css?("a[href='/articles/new']") }

  expect(page).to have_selector 'td', :text => "#{$GLOBAL_HASH[hash_key]}_title"
  expect(page).to have_selector 'td', :text => "#{$GLOBAL_HASH[hash_key]}_text"
end

Then(/^verify that article updated with prefix from GLOBAL_HASH "(.*)"$/) do |hash_key|
  expect(page).to have_selector 'td', :text => "#{$GLOBAL_HASH[hash_key]}_title"
  expect(page).to have_selector 'td', :text => "#{$GLOBAL_HASH[hash_key]}_text"
end

Then(/^verify article absence with prefix from GLOBAL_HASH "([^"]*)"$/) do |hash_key|
  expect(page).to_not have_selector 'td', :text => "#{$GLOBAL_HASH[hash_key]}_title"
  expect(page).to_not have_selector 'td', :text => "#{$GLOBAL_HASH[hash_key]}_text"
end

When(/^create article and put random prefix in GLOBAL_HASH "(.*)"$/) do |hash_key|
  create_article(hash_key)
end

When(/^generate random prefix number and put value in GLOBAL_HASH "(.*)"$/) do |hash_key|
  $GLOBAL_HASH[hash_key] = rand(999..99999).to_s
  puts "Random prefix: #{$GLOBAL_HASH[hash_key]}"
end


When(/^click 'Edit' link related to title from GLOBAL_HASH "([^"]*)"$/) do |hash_key|
  find(:xpath, "//td[contains(., #{$GLOBAL_HASH[hash_key]})]/..//a[.='Edit']").click
  wait_until { has_xpath?(".//h1[.='Edit article']") }
end

When(/^click 'Update Article' button$/) do
  find("input[value='Update Article']").click
  wait_until { has_css?("p>strong") }
end

When(/^click 'Destroy' link related to title from GLOBAL_HASH "([^"]*)"$/) do |hash_key|
  find(:xpath, "//td[contains(., #{$GLOBAL_HASH[hash_key]})]/..//a[.='Destroy']").click
  wait_until { has_css?("a[href='/articles/new']") }
end


When(/^click 'Show' link related to title from GLOBAL_HASH "([^"]*)"$/) do |hash_key|
  find(:xpath, ".//td[contains(., #{$GLOBAL_HASH[hash_key]})]/..//a[.='Show']").click
  wait_until { has_css?("p>strong") }
end

When(/^fill 'Commenter' form with prefix from GLOBAL_HASH "([^"]*)"$/) do |hash_key|
  sleep 0.1
  wait_until { has_css?("#comment_commenter") }
  random_commenter = $GLOBAL_HASH[hash_key] + "_commenter"
  find("#comment_commenter").set random_commenter
  puts "Commenter: #{random_commenter}"
end

When(/^fill 'Body' form with prefix from GLOBAL_HASH "([^"]*)"$/) do |hash_key|
  wait_until { has_css?("#comment_body") }
  random_comment = $GLOBAL_HASH[hash_key] + "_comment"
  find("#comment_body").set random_comment
  puts "Body: #{random_comment}"
end

When(/^click 'Create Comment' button$/) do
  wait_until { has_css?("input[value='Create Comment']") }
  find("input[value='Create Comment']").click
  wait_until { has_css?("p>strong") }
end

Then(/^verify that comment created with prefix from GLOBAL_HASH "(.*)"$/) do |hash_key|
  expect(page).to have_selector 'p', :text => "#{$GLOBAL_HASH[hash_key]}_commenter"
  expect(page).to have_selector 'p', :text => "#{$GLOBAL_HASH[hash_key]}_comment"
end

When(/^click 'Destroy Comment' link related to title from GLOBAL_HASH "([^"]*)"$/) do |hash_key|
  commenter_list = all(:xpath, "//p[contains(.,'commenter')]")
  commenter_list_text = commenter_list.map { |el| el.text }
  index = commenter_list_text.index("Commenter: " + $GLOBAL_HASH[hash_key] + "_commenter")
  all(:xpath, "//a[.='Destroy Comment']")[index].click
end

Then(/^verify comment absence with prefix from GLOBAL_HASH "([^"]*)"$/) do |hash_key|
  expect(page).to_not have_selector 'p', :text => "#{$GLOBAL_HASH[hash_key]}_commenter"
  expect(page).to_not have_selector 'p', :text => "#{$GLOBAL_HASH[hash_key]}_comment"
end

Then(/^verify that article created with prefix from GLOBAL_HASH "([^"]*)" in common list$/) do |hash_key|
  expect(page).to have_selector 'td', :text => "#{$GLOBAL_HASH[hash_key]}_title"
  expect(page).to have_selector 'td', :text => "#{$GLOBAL_HASH[hash_key]}_text"
end

When(/^create comment and put random prefix in GLOBAL_HASH "([^"]*)"$/) do |hash_key|
  create_comment(hash_key)
end
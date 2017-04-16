module MethodsLib
  def wait_until
    Timeout.timeout(3) do
      sleep(0.1) until yield
    end
  end

  def js_confirm(accept)
    if accept == 'ok'
      page.driver.browser.switch_to.alert.accept
    else
      page.driver.browser.switch_to.alert.dismiss
    end
    # page.driver.browser.switch_to.alert.text # the confirmation text
  end

  def visit_address(address, login, pass)
    visit "http://#{login}:#{pass}@#{address}"
  end

  def create_article(hash_key)
    visit_address("localhost:3000/articles/", "admin", "admin")

    find("a[href='/articles/new']").click
    wait_until { has_css?("#new_article") }

    $GLOBAL_HASH[hash_key] = rand(9999).to_s
    puts "Random prefix: #{$GLOBAL_HASH[hash_key]}"

    random_title = $GLOBAL_HASH[hash_key] + "_title"
    fill_in('Title', :with => random_title)
    puts "Title: #{random_title}"

    random_text = $GLOBAL_HASH[hash_key] + "_text"
    fill_in('Text', :with => random_text)
    puts "Text: #{random_text}"

    find("input[type='submit']").click
    wait_until { has_css?("p>strong") }

    expect(page).to have_selector 'p', :text => "#{$GLOBAL_HASH[hash_key]}_title"
    expect(page).to have_selector 'p', :text => "#{$GLOBAL_HASH[hash_key]}_text"

    find(:xpath, ".//a[.='Back']").click
    wait_until { has_css?("a[href='/articles/new']") }

    expect(page).to have_selector 'td', :text => "#{$GLOBAL_HASH[hash_key]}_title"
    expect(page).to have_selector 'td', :text => "#{$GLOBAL_HASH[hash_key]}_text"
  end

end
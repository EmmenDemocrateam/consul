require "rails_helper"

describe "Cookies message" do

  scenario "Show cookies message" do
    visit root_path

    within "#cookies_message" do
      expect(page).to have_content("Your experience on this website was improving with using cookies")
      expect(page).to have_link "Accept cookies", href: root_path(cookies_accepted: true)
      expect(page).to have_link "More information", href: page_path("cookies")
    end
  end

  scenario "Hide cookies message when accept" do
    visit root_path

    within "#cookies_message" do
      click_link "Accept cookies"
    end

    expect(page).to have_current_path(root_path(cookies_accepted: true))

    expect(page).not_to have_selector "#cookies_message"
    expect(page).not_to have_content "Your experience on this website was improving with using cookies"
    expect(page).not_to have_link "Accept cookies", href: root_path(cookies_accepted: true)
    expect(page).not_to have_link "More information", href: page_path("cookies")

    visit debates_path

    expect(page).not_to have_selector "#cookies_message"

    visit proposals_path

    expect(page).not_to have_selector "#cookies_message"
  end
end

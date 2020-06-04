require "rails_helper"

describe "Admin users" do
  let(:admin) { create(:administrator) }
  let!(:user) { create(:user, username: "Jose Luis Balbin") }

  before do
    login_as(admin.user)
    visit admin_users_path
  end

  scenario "Index" do
    expect(page).to have_link user.name
    expect(page).to have_content user.email
    expect(page).to have_content admin.name
    expect(page).to have_content admin.email
  end

  scenario "The username links to their public profile" do
    click_link user.name

    expect(page).to have_current_path(user_path(user))
  end

  scenario "Do not show erased users" do
    erased_user = create(:user, username: "Erased")
    erased_user.erase

    expect(page).not_to have_link user_path(erased_user)

    fill_in :search, with: "Erased"
    click_button "Search"

    expect(page).to have_content "There are no users."
  end

  scenario "Search" do
    fill_in :search, with: "Luis"
    click_button "Search"

    expect(page).to have_content user.name
    expect(page).to have_content user.email
    expect(page).not_to have_content admin.name
    expect(page).not_to have_content admin.email
  end
end

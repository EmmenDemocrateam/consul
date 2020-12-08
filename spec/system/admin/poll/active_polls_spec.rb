require "rails_helper"

describe "Admin Active polls" do
  before do
    admin = create(:administrator)
    login_as(admin.user)
  end

  scenario "Add", :js do
    expect(ActivePoll.first).to be nil

    visit admin_polls_path
    click_link "Polls description"

    fill_in_ckeditor "Description", with: "Active polls description"
    click_button "Save"

    expect(page).to have_content "Polls description updated successfully."
    expect(ActivePoll.first.description).to eq "<p>Active polls description</p>\r\n"
  end

  scenario "Edit", :js do
    create(:active_poll, description_en: "Old description")

    visit polls_path
    within ".polls-description" do
      expect(page).to have_content "Old description"
    end

    visit edit_admin_active_polls_path
    fill_in_ckeditor "Description", with: "New description"
    click_button "Save"

    expect(page).to have_content "Polls description updated successfully."

    visit polls_path
    within ".polls-description" do
      expect(page).not_to have_content "Old description"
      expect(page).to have_content "New description"
    end
  end

  scenario "Allows images in CKEditor", :js do
    html_content = "<p><img src='/image.jpg' alt='Image title'></img></p>\r\n"
    create(:active_poll, description_en: html_content)

    visit edit_admin_active_polls_path
    expect(page).to have_css(".cke_toolbar .cke_button__image_icon")

    visit polls_path
    within ".polls-description" do
      expect(page).to have_css "img[src$='image.jpg']"
      expect(page).to have_css "img[alt='Image title']"
    end
  end
end

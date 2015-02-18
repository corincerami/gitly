require "rails_helper"

feature "Shortening links" do
  it "shows a shortened link" do
    visit new_link_path

    fill_in "URL", with: "http://www.github.com/chrisccerami"
    click_on "Shorten"

    expect(page).to have_content "Link created"
    expect(page).to have_content "http://www.github.com/chrisccerami"
  end
end

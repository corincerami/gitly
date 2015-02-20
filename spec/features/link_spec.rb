require "rails_helper"

feature "Shortening links" do
  it "shows a shortened link" do
    visit new_link_path

    fill_in "URL", with: "http://www.github.com/chrisccerami"
    click_on "Shorten"

    expect(page).to have_content "Link created"
    expect(page).to have_content "http://www.github.com/chrisccerami"
  end

  it "doesn't create a duplicate shortened link" do
    link = FactoryGirl.create(:link)

    visit new_link_path

    fill_in "URL", with: link.long_url
    click_on "Shorten"

    expect(page).to have_content link.short_url
  end

  it "index shows most popular links" do
    pop_links = FactoryGirl.create_list(:link, 5)
    pop_links.each do |link|
      link.analytic = FactoryGirl.create(:analytic, visits: 5000, link: link)
    end

    unpop_links = FactoryGirl.create_list(:link, 5)
    unpop_links.each do |link|
      link.analytic = FactoryGirl.create(:analytic, visits: 1, link: link)
    end

    visit links_path

    expect(page).to have_content "Most Visited Links"
    pop_links.each do |link|
      expect(page).to have_content link.short_url
    end

    unpop_links.each do |link|
      expect(page).not_to have_content link.short_url
    end
  end
end

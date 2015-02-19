require "rails_helper"

feature "View analytics" do
  before(:each) do
    @link = FactoryGirl.create(:link)
    @analytic = @link.analytic
  end

  it "should display correct analytics" do
    visit "/#{@link.short_url}"
    visit "/#{@link.short_url}"
    visit link_path(@link)
    click_on "View Analytics"

    expect(page).to have_content "Total visits: 2"
    expect(page).to have_content "Unique visits: 1"
    expect(page).to have_content "Visitors' most common browser: Other"
    expect(page).to have_content "Visitors' most common platform: Other"
  end

  it "should increment visits" do
    v = @analytic.visits
    visit "/#{@link.short_url}"
    visit analytic_path(@analytic)

    expect(page).to have_content "Total visits: #{v + 1}"
  end

  it "should increment unique visits correctly" do
    uv = @analytic.unique_visits
    visit "/#{@link.short_url}"
    visit "/#{@link.short_url}"
    visit analytic_path(@analytic)

    expect(page).to have_content "Unique visits: #{uv + 1}"
  end
end

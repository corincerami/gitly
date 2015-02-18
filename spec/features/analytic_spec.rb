require "rails_helper"

feature "View analytics" do
  before(:each) do
    @link = FactoryGirl.create(:link)
    @analytics = @link.analytic
    visit analytic_path(@analytics)
  end

  it "should display correct analytics" do
    expect(page).to have_content "Total visits: #{@analytics.visits}"
    expect(page).to have_content "Unique visits: #{@analytics.unique_visits}"
  end

  it "should increment visits" do
    v = @analytics.visits
    visit "/#{@link.short_url}"
    visit analytic_path(@analytics)

    expect(page).to have_content "Total visits: #{v + 1}"
  end

  it "should increment unique visits correctly" do
    uv = @analytics.unique_visits
    visit "/#{@link.short_url}"
    visit "/#{@link.short_url}"
    visit analytic_path(@analytics)

    expect(page).to have_content "Unique visits: #{uv + 1}"
  end
end

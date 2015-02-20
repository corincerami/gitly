require "rails_helper"

describe Link do
  describe "attributes" do
    it { should respond_to :long_url }
    it { should respond_to :short_url }
  end

  describe "associations" do
    it { should have_one :analytic }
  end

  describe "validations" do
    it { should validate_presence_of :long_url }
    it { should validate_presence_of :short_url }
  end

  describe "shorten" do
    it "should create a short_url" do
      link = FactoryGirl.create(:link)
      expect(link.short_url.length).to eq 6
      expect(link.short_url.class).to eq String
    end
  end

  describe "#most_popular" do
    it "should return the 5 most visited links" do
      FactoryGirl.create_list(:link, 6)
      pop_links = Link.all.first(5)
      unpop = Link.last

      pop_links.each do |link|
        link.analytic = FactoryGirl.create(:analytic, visits: 5000, link: link)
        expect(Link.most_popular).to include(link)
      end

      expect(Link.most_popular).not_to include(unpop)
    end
  end

  describe "#most_recent" do
    it "should return the 5 most recent links" do
      FactoryGirl.create_list(:link, 5)
      latest = Link.first(5)
      oldest = FactoryGirl.create(:link, created_at: 1.day.ago)

      latest.each do |link|
        expect(Link.most_recent).to include(link)
      end

      expect(Link.most_recent).not_to include(oldest)
    end
  end
end

require "rails_helper"

describe Link do
  describe "attributes" do
    it { should respond_to :long_url }
    it { should respond_to :short_url }
  end

  describe "associations" do

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
end

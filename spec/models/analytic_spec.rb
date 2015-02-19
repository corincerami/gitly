require "rails_helper"

describe Analytic do
  describe "attributes" do
    it { should respond_to :visits }
    it { should respond_to :unique_visits }
  end

  describe "associations" do
    it { should belong_to :link }
    it { should have_many :unique_visitors }
  end

  describe "validations" do
    it { should validate_presence_of :visits }
    it { should validate_presence_of :unique_visits }
    it { should validate_numericality_of :visits }
    it { should validate_numericality_of :unique_visits }
  end

  describe "most_common_browser" do
    before(:each) do
      @analytic = FactoryGirl.create(:analytic)
      @analytic.unique_visitors.create(visitor_ip: "0.0.0.0",
                                      browser: "Chrome")
      @analytic.unique_visitors.create(visitor_ip: "0.0.0.0",
                                      browser: "Firefox")
    end

    it "should return most commonly used browser" do
      @analytic.unique_visitors.create(visitor_ip: "0.0.0.0",
                                      browser: "Chrome")
      browser = @analytic.most_common_browser
      expect(browser).to eq("Chrome")
    end

    it "should work with a tie" do
      @analytic.unique_visitors.create(visitor_ip: "0.0.0.0",
                                      browser: "Chrome")
      @analytic.unique_visitors.create(visitor_ip: "0.0.0.0",
                                      browser: "Firefox")
      browser = @analytic.most_common_browser
      expect(["Chrome", "Firefox"]).to include browser
    end

    it "should return nil when no visitors yet" do
      analytic = FactoryGirl.create(:analytic)
      analytic.unique_visitors.destroy_all
      browser = analytic.most_common_browser

      expect(browser).to eq(nil)
    end
  end

  describe "most_common_platform" do
    before(:each) do
      @analytic = FactoryGirl.create(:analytic)
      @analytic.unique_visitors.create(visitor_ip: "0.0.0.0",
                                      platform: "Windows")
      @analytic.unique_visitors.create(visitor_ip: "0.0.0.0",
                                      platform: "Mac")
    end

    it "should return most commonly used platform" do
      @analytic.unique_visitors.create(visitor_ip: "0.0.0.0",
                                      platform: "Windows")
      platform = @analytic.most_common_platform
      expect(platform).to eq("Windows")
    end

    it "should work with a tie" do
      @analytic.unique_visitors.create(visitor_ip: "0.0.0.0",
                                      platform: "Windows")
      @analytic.unique_visitors.create(visitor_ip: "0.0.0.0",
                                      platform: "Mac")
      platform = @analytic.most_common_platform
      expect(["Mac", "Windows"]).to include platform
    end

    it "should return nil when no visitors yet" do
      analytic = FactoryGirl.create(:analytic)
      analytic.unique_visitors.destroy_all
      platform = analytic.most_common_platform

      expect(platform).to eq(nil)
    end
  end
end

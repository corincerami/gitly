require "rails_helper"

describe LinksController do
  describe "GET 'redirect'" do
    before(:each) do
      @link = FactoryGirl.create(:link)
      get :redirect, { "short_url" => @link.short_url }
    end

    it "redirects to the correct location" do
      binding.pry
      expect(response).to redirect_to(@link.long_url)
    end
  end
end

require "rails_helper"

describe LinksController do
  describe "GET 'redirect'" do
    before(:each) do
      @link = FactoryGirl.create(:link)
      get :redirect, { "short_url" => @link.short_url }
    end

    it "redirects to the correct location" do
      expect(response).to redirect_to(@link.long_url)
    end

    it "renders the new page when invalid" do
      get :redirect, { "short_url" => "not_a_valid_link" }
      expect(response).to render_template :new
    end
  end
end

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
end

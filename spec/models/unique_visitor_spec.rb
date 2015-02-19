require "rails_helper"

describe UniqueVisitor do
  describe "attributes" do
    it { should respond_to :visitor_ip }
    it { should respond_to :analytic_id }
    it { should respond_to :browser }
    it { should respond_to :browser_version }
    it { should respond_to :platform }
  end

  describe "validations" do
    it { should validate_presence_of :visitor_ip }
    it { should validate_presence_of :analytic_id }
  end

  describe "associations" do
    it { should belong_to :analytic }
  end
end

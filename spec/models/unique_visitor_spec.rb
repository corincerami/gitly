require "rails_helper"

describe UniqueVisitor do
  describe "attributes" do
    it { should respond_to :visitor_ip }
    it { should respond_to :analytic_id }
  end

  describe "validations" do
    it { should validate_presence_of :visitor_ip }
    it { should validate_presence_of :analytic_id }
  end

  describe "associations" do
    it { should belong_to :analytic }
  end
end

require "rails_helper"

describe Analytic do
  describe "attributes" do
    it { should respond_to :visits }
    it { should respond_to :unique_visits }
  end

  describe "associations" do
    it { should belong_to :link }
  end

  describe "validations" do
    it { should validate_presence_of :visits }
    it { should validate_presence_of :unique_visits }
    it { should validate_numericality_of :visits }
    it { should validate_numericality_of :unique_visits }
  end
end

FactoryGirl.define do
  factory :link do
    long_url "http://www.google.com"
    after(:build) do |link|
      link.shorten
    end
  end
end

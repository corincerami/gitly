FactoryGirl.define do
  factory :link do
    long_url "http://www.google.com"
    after(:build) do |link|
      link.shorten
    end
  end

  factory :analytic do
    visits 1000
    unique_visits 250
    link
  end
end

FactoryGirl.define do
  factory :link do
    sequence(:long_url) { |n| "http://www.google#{n}.com" }
    after(:build) do |link|
      link.shorten
    end
  end

  factory :analytic do
    visits 1000
    unique_visits 250
    link
    after(:create) do |a|
      a.unique_visitors << FactoryGirl.create(:unique_visitor, analytic: a)
    end
  end

  factory :unique_visitor do
    visitor_ip "0.0.0.0"
    browser "A browser"
    browser_version "1"
    platform "An OS"
  end
end

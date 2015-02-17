class Link < ActiveRecord::Base
  validates :long_url, presence: true
  validates :short_url, presence: true
end

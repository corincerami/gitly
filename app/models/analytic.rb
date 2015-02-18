class Analytic < ActiveRecord::Base
  belongs_to :link
  has_many :unique_visitors

  validates :visits, presence: true, numericality: true
  validates :unique_visits, presence: true, numericality: true
end

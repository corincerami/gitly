class Analytic < ActiveRecord::Base
  belongs_to :link

  validates :visits, presence: true, numericality: true
  validates :unique_visits, presence: true, numericality: true
end

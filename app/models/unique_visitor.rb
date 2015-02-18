class UniqueVisitor < ActiveRecord::Base
  belongs_to :analytic

  validates :visitor_ip, presence: true
  validates :analytic_id, presence: true
end

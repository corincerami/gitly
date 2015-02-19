class Analytic < ActiveRecord::Base
  belongs_to :link
  has_many :unique_visitors

  validates :visits, presence: true, numericality: true
  validates :unique_visits, presence: true, numericality: true

  def most_common_browser
    browsers = unique_visitors.all.group_by{ |uv| uv.browser }
    if browsers.any?
      browser = browsers.sort_by { |b| b.length }.first.first
    end
  end

  def most_common_platform
    browsers = unique_visitors.all.group_by{ |uv| uv.platform }
    if browsers.any?
      browser = browsers.sort_by { |b| b.length }.first.first
    end
  end
end

class Link < ActiveRecord::Base
  include Geokit::Geocoders
  has_one :analytic

  validates :long_url, presence: true, uniqueness: true
  validates :short_url, presence: true, uniqueness: true

  after_create :start_analyzing

  def shorten
    # created a random 6 character string
    characters = ["a", "b", "c", "d", "e", "f", "g",
                  "h", "i", "j", "k", "l", "m", "n",
                  "o", "p", "q", "r", "s", "t", "u",
                  "v", "w", "x", "y", "z", "A", "B",
                  "C", "D", "E", "F", "G", "H", "I",
                  "J", "K", "L", "M", "N", "O", "P",
                  "Q", "R", "S", "T", "U", "V", "W",
                  "X", "Y", "Z", "1", "2", "3", "4",
                  "5", "6", "7", "8", "9", "0"]
    path = ""
    6.times { path << characters[rand(61)] }
    if Link.all.select { |l| l.short_url == path }.any?
      self.shorten
    else
      self.short_url = path
    end
  end

  def start_analyzing
    Analytic.create(link: self)
  end

  def track_visits(request)
    analytic.increment!(:visits, by = 1)
    if !analytic.unique_visitors.any? { |uv| uv.visitor_ip == request.ip }
      browser = Browser.new(ua: request.env["HTTP_USER_AGENT"])
      country = location_from_ip(request.ip)
      analytic.unique_visitors.create(visitor_ip: request.ip,
                                      browser: browser.name,
                                      browser_version: browser.version,
                                      platform: browser.platform.capitalize,
                                      country: country)
      analytic.increment!(:unique_visits, by = 1)
    end
  end

  def self.most_popular
    joins(:analytic).order("analytics.visits").first(5)
  end

  def self.most_recent
    order("created_at DESC").first(5)
  end

  private

  def location_from_ip(ip)
    location = IpGeocoder.geocode(ip)
    location.country_code
  end
end

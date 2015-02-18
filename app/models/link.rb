class Link < ActiveRecord::Base
  validates :long_url, presence: true, uniqueness: true
  validates :short_url, presence: true, uniqueness: true

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
end

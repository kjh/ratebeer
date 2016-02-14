class Membership < ActiveRecord::Base
  belongs_to :beer_club
  belongs_to :user
  
  def to_s
    "#{self.beer_club.name}"
  end
end

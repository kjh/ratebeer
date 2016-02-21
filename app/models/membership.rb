class Membership < ActiveRecord::Base
  belongs_to :beer_club
  belongs_to :user
  
  def to_s
    "#{self.beer_club.name}"
  end
  
  def self.is_a_member? id
    self.find_by_user_id(id)
  end
end

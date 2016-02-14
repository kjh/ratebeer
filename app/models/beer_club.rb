class BeerClub < ActiveRecord::Base
  #clubi
  has_many :users, through: :memberships
  has_many :memberships, dependent: :destroy
  
  def to_s
    "#{self.name}, #{self.founded}, #{self.city}"
  end
end

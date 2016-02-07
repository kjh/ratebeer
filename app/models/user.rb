class User < ActiveRecord::Base
  include RatingAverage
  
  validates :username, uniqueness: true,
                       length: { minimum: 3 },
                       length: { maximum: 15 }
  validates :password, length: { minimum: 4 },
                       :format => {:with => /[A-Z]/, message: "must include one uppercase letter."}
                                           
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  
  has_secure_password
end

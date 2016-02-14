class User < ActiveRecord::Base
  include RatingAverage
  
  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 15 }
  validates :password, length: { minimum: 4 },
                       :format => {:with => /[A-Z]/, message: "must include one uppercase letter."}
                                           
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  #clubi
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
  
  has_secure_password
  
  def favorite_beer
    return nil if ratings.empty?   # palautetaan nil jos reittauksia ei ole
    #ratings.first.beer             # palataan ensimmaiseen reittaukseen liittyvä olut
    #ratings.sort_by{ |r| r.score }.last.beer # hakee kaikki + järjestys muistissa
    ratings.order(score: :desc).limit(1).first.beer # tietokannassa
  end
end

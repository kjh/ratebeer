class Rating < ActiveRecord::Base
  belongs_to :beer
  belongs_to :user
  
  validates :score, numericality: { greater_than_or_equal_to: 1,
                                      less_than_or_equal_to: 50,
                                      only_integer: true }
                                      
  scope :recent, -> { all.order(created_at: :desc).limit(5) }
  scope :top_raters, -> { User.top 3 }
  scope :top_beers, -> { Beer.top 3 }
  scope :top_breweries, -> { Brewery.top 3 }
  #scope :top_styles, -> { Beer.top_styles 3 }
  #scope :retired, -> { where active:[nil,false] }   
  
  #kolme reittausten keskiarvon perusteella parasta olutta ja panimoa
  #kolme eniten reittauksia tehnyttä käyttäjää
  #viisi viimeksi tehtyä reittausta.                                   
  
  def to_s
    "#{self.beer.name} #{self.score}"
  end
end

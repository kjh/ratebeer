class Beer < ActiveRecord::Base
  include RatingAverage
  
  #belongs_to :brewery
  #has_many :ratings, dependent: :destroy
  
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  #has_many :users, through: :ratings
  #has_many :raters, through: :ratings, source: :user
  has_many :raters, -> { uniq }, through: :ratings, source: :user
  
  validates :name, presence: true
  validates :style, presence: true
  
  #def average
  #  return 0 if ratings.empty?
  #  ratings.map{ |r| r.score }.sum / ratings.count.to_f
  #end
  
  def to_s
    "#{self.name}, #{self.brewery.name}"
  end
end

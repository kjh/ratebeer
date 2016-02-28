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
  
  def self.top(n)    
     sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating) }
     sorted_by_rating_in_desc_order.take(3)
     
     # palauta listalta parhaat n kappaletta
     # miten? ks. http://www.ruby-doc.org/core-2.1.0/Array.html
  end 
  
  def self.top_styles(n)    
     sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating) }
     count = 0
     styles = []
     sorted_by_rating_in_desc_order.each do |b|
       if (count < n)
         styles << b.style if (!styles.include?(b.style))
         count += 1
       else
         break
       end
     end
     
     styles
     
     # palauta listalta parhaat n kappaletta
     # miten? ks. http://www.ruby-doc.org/core-2.1.0/Array.html
  end 
  
  def to_s
    "#{self.name}, #{self.brewery.name}"
  end
end

module RatingAverage
  extend ActiveSupport::Concern

  def rating_average
    self.ratings.average(:score).to_f
  end
end
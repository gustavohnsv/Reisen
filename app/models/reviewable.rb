module Reviewable
  extend ActiveSupport::Concern

  included do
    has_many :reviews, as: :reviewable, dependent: :destroy
  end

  def average_rating
    reviews.average_rating
  end

  def reviews_count
    reviews.count
  end
end
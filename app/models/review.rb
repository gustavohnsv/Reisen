class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  belongs_to :user

  validates :rating, presence: true, 
                     numericality: { 
                       only_integer: true, 
                       greater_than_or_equal_to: 1, 
                       less_than_or_equal_to: 5 
                     }
  validates :comment, length: { maximum: 1000 }, allow_blank: true
  validates :title, length: { maximum: 100 }, allow_blank: true
  validates :user_id, uniqueness: { 
    scope: [:reviewable_type, :reviewable_id],
    message: "já avaliou este item" 
  }

  scope :recent, -> { order(created_at: :desc) }
  scope :by_rating, ->(rating) { where(rating: rating) }
  scope :highest_rated, -> { order(rating: :desc) }

  def self.average_rating
    average(:rating).to_f.round(1)
  end
end
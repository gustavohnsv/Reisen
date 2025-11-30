class ScriptItem < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :script
  has_many :reviews, dependent: :destroy
  has_many :script_item_photos, dependent: :destroy  # ← ADICIONAR

  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :date_time_start, presence: true
  validates :estimated_cost, presence: true
  
  def average_rating
    return 0 if reviews.empty?
    (reviews.sum(:rating).to_f / reviews.count).round(1)
  end
  
  def total_reviews
    reviews.count
  end
  
  # ← ADICIONAR ESTE MÉTODO
  def total_photos
    script_item_photos.count
  end
end
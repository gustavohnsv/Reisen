class ScriptItem < ApplicationRecord
  belongs_to :user, :optional => true
  belongs_to :script

  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :date_time_start, presence: true
  validates :estimated_cost, presence: true
end

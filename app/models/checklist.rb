class Checklist < ApplicationRecord
  belongs_to :user

  validates :title, presence: true

  has_many :checklist_items, dependent: :destroy
end

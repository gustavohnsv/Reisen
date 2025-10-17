class ChecklistItem < ApplicationRecord
  belongs_to :checklist

  validates :description, presence: true, length: { minimum: 3 }
end

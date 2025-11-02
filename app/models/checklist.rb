class Checklist < ApplicationRecord
  belongs_to :user

  validates :title, presence: true

  has_many :checklist_items, dependent: :destroy
  has_many :checklist_participants, dependent: :destroy
  has_many :participants, through: :checklist_participants, source: :user

  accepts_nested_attributes_for :checklist_items,
                                reject_if: :all_blank,
                                allow_destroy: true
end

class Notice < ApplicationRecord
  scope :visible, -> { where(visible: true) }

  belongs_to :user, optional: true
  validates :title, presence: true
  validates :body, presence: true
end

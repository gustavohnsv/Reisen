class Script < ApplicationRecord
  has_secure_token :shareable_token

  validates :title, presence: true

  belongs_to :user

  has_many :participants, dependent: :destroy
  has_many :script_comments, dependent: :destroy
  has_many :script_items, dependent: :destroy
  has_many :script_spents, dependent: :destroy

  has_many :users, through: :participants
end

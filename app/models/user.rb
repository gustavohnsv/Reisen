class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  
  has_many :scripts, dependent: :destroy
  has_many :checklists, dependent: :destroy
  has_many :script_participants, dependent: :destroy
  has_many :checklist_participants, dependent: :destroy

  has_many :script_comments, dependent: :destroy
  has_many :script_items, dependent: :destroy
  has_many :script_spents, dependent: :destroy
  has_many :checklist_items, dependent: :destroy

  has_many :participated_scripts, through: :script_participants, source: :script
  has_many :participated_checklists, through: :checklist_participants, source: :checklist
  has_one_attached :avatar
  validate :avatar_type_and_size

  private

  def avatar_type_and_size
    return unless avatar.attached?

    # Validate content type is an image
    content_type = avatar.blob.content_type
    unless content_type.present? && content_type.start_with?("image")
      errors.add(:avatar, "deve ser uma imagem")
    end

    # Validate size (2 MB max)
    max_size = 2 * 1024 * 1024
    if avatar.blob.byte_size > max_size
      errors.add(:avatar, "é muito grande (máximo 2MB)")
    end
  end
end

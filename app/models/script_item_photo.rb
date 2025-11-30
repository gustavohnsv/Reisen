class ScriptItemPhoto < ApplicationRecord
  belongs_to :script_item
  belongs_to :user
  has_one_attached :image
  
  validates :image, presence: true
  validate :image_type_and_size
  validates :description, length: { maximum: 500 }, allow_blank: true
  
  private
  
  def image_type_and_size
    return unless image.attached?
    
    # Validate content type
    content_type = image.blob.content_type
    unless content_type.present? && content_type.start_with?("image/")
      errors.add(:image, "deve ser uma imagem")
    end
    
    # Validate size (5 MB max)
    max_size = 5 * 1024 * 1024
    if image.blob.byte_size > max_size
      errors.add(:image, "é muito grande (máximo 5MB)")
    end
  end
end
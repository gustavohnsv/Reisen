class ChecklistParticipant < ApplicationRecord
  belongs_to :user
  belongs_to :checklist

  ROLES = %w[collaborator read_only].freeze

  validates :role, inclusion: { in: ROLES }

  def collaborator?
    role == 'collaborator'
  end

  def read_only?
    role == 'read_only'
  end
end

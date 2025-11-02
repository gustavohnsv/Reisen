require 'rails_helper'

RSpec.describe ChecklistParticipant, type: :model do
  it 'is invalid with unknown role' do
    user = create(:user)
    checklist = create(:checklist, user: user)
    cp = ChecklistParticipant.new(user: user, checklist: checklist, role: 'x')
    expect(cp).not_to be_valid
    expect(cp.errors[:role]).to be_present
  end

  it 'helper methods reflect role' do
    user = create(:user)
    checklist = create(:checklist, user: user)
    cp = ChecklistParticipant.create!(user: user, checklist: checklist, role: 'collaborator')
    expect(cp.collaborator?).to be true
    expect(cp.read_only?).to be false
  end
end

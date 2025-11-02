require 'rails_helper'

RSpec.describe ChecklistParticipant, type: :model do
  it 'validates role inclusion' do
    user = create(:user)
    checklist = create(:checklist, user: user)
    p = ChecklistParticipant.new(user: user, checklist: checklist, role: 'bad')
    expect(p).not_to be_valid
    expect(p.errors[:role]).to be_present
  end

  it 'collaborator/read_only helpers' do
    user = create(:user)
    checklist = create(:checklist, user: user)
    cp = ChecklistParticipant.create!(user: user, checklist: checklist, role: 'collaborator')
    expect(cp.collaborator?).to be true
    expect(cp.read_only?).to be false
  end
end

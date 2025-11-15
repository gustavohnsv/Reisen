require 'rails_helper'

RSpec.describe ScriptParticipant, type: :model do
  it 'is valid with a valid role' do
    user = create(:user)
    script = create(:script, user: user)
    p = ScriptParticipant.new(user: user, script: script, role: 'collaborator')
    expect(p).to be_valid
  end

  it 'is invalid with an unknown role' do
    user = create(:user)
    script = create(:script, user: user)
    p = ScriptParticipant.new(user: user, script: script, role: 'unknown')
    expect(p).not_to be_valid
    expect(p.errors[:role]).to be_present
  end

  it 'helper methods reflect role' do
    user = create(:user)
    script = create(:script, user: user)
    p = ScriptParticipant.create!(user: user, script: script, role: 'read_only')
    expect(p.read_only?).to be true
    expect(p.collaborator?).to be false
  end
end

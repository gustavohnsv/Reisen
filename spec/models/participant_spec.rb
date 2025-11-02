require 'rails_helper'

RSpec.describe Participant, type: :model do
  it 'has valid factory if present' do
    user = create(:user)
    script = create(:script, user: user)
    p = Participant.new(user: user, script: script, role: 'collaborator')
    expect(p).to be_valid
  end

  it 'validates role inclusion' do
    user = create(:user)
    script = create(:script, user: user)
    p = Participant.new(user: user, script: script, role: 'invalid')
    expect(p).not_to be_valid
    expect(p.errors[:role]).to be_present
  end

  it 'helper methods reflect role' do
    user = create(:user)
    script = create(:script, user: user)
    p = Participant.create!(user: user, script: script, role: 'read_only')
    expect(p.read_only?).to be true
    expect(p.collaborator?).to be false
  end
end
require 'rails_helper'

RSpec.describe Participant, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

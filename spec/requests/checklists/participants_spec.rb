require 'rails_helper'

RSpec.describe 'Checklists::Participants', type: :request do
  let(:owner) { create(:user) }
  let(:other) { create(:user) }
  let(:checklist) { create(:checklist, user: owner) }

  before { sign_in owner }

  it 'creates a checklist participant' do
    post checklist_participants_path(checklist), params: { email: other.email, role: 'read_only' }
    expect(response).to redirect_to(checklist_path(checklist))
    follow_redirect!
    expect(response.body).to include('Participante adicionado com sucesso')
    expect(checklist.checklist_participants.exists?(user_id: other.id)).to be true
  end

  it 'destroys a checklist participant' do
    cp = checklist.checklist_participants.create!(user: other, role: 'collaborator')
    delete checklist_participant_path(checklist, cp)
    expect(response).to redirect_to(checklist_path(checklist))
    follow_redirect!
    expect(response.body).to include('Participante removido')
    expect(checklist.checklist_participants.exists?(id: cp.id)).to be false
  end
end

require 'rails_helper'

RSpec.describe 'Scripts::Participants', type: :request do
  let(:owner) { create(:user) }
  let(:other) { create(:user) }
  let(:script) { create(:script, user: owner) }

  before { sign_in owner }

  it 'adds a participant when owner' do
    post script_participants_path(script), params: { email: other.email, role: 'collaborator' }
    expect(response).to redirect_to(script_path(script))
    follow_redirect!
    expect(response.body).to include('Participante adicionado com sucesso')
    expect(script.script_participants.exists?(user_id: other.id)).to be true
  end

  it 'rejects when email missing' do
    post script_participants_path(script), params: { email: '' }
    expect(response).to redirect_to(script_path(script))
    follow_redirect!
    expect(response.body).to include('E-mail é obrigatório')
  end

  it 'removes participant when owner' do
    part = script.script_participants.create!(user: other, role: 'collaborator')
    delete script_participant_path(script, part)
    expect(response).to redirect_to(script_path(script))
    follow_redirect!
    expect(response.body).to include('Participante removido')
    expect(script.script_participants.exists?(id: part.id)).to be false
  end
end



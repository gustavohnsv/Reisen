require 'rails_helper'

RSpec.describe 'Acesso Multiplataforma', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'permite ao viajante acessar seus dados ao fazer login em outro dispositivo' do
    # Cria usuário e um roteiro associado
    user = FactoryBot.create(:user, email: 'traveler@example.com', password: 'password')
    script = FactoryBot.create(:script, title: 'Viagem a Testland', user: user)

    # Dispositivo A: loga (simulado) e verifica que o roteiro existe
    login_as(user, scope: :user)
    visit profile_path(user)
    expect(page).to have_content('Viagem a Testland')

    # Simula acessar de outro dispositivo: limpa sessão e loga novamente
    logout(:user)
    login_as(user, scope: :user)
    visit profile_path(user)

    # O roteiro deve continuar acessível ao usuário
    expect(page).to have_content('Viagem a Testland')
  end
end

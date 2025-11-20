require 'rails_helper'

RSpec.describe 'Excluir conta', type: :system do
  before do
    driven_by(:chrome_or_default)
  end

  it 'permite ao usuário remover a própria conta' do
    user = FactoryBot.create(:user, password: '123456', password_confirmation: '123456')
    login_as(user, scope: :user)

    visit edit_profile_path(user)
    expect(page).to have_button('Excluir conta')

    accept_confirm do
      click_button 'Excluir conta'
    end

    expect(page).to have_current_path(root_path)
    expect(page).to have_content('Conta excluída com sucesso.')
    expect(User.find_by(id: user.id)).to be_nil
  end
end

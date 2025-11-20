Dado('que estou autenticado e na página de edição do meu perfil') do
  password = '123456'
  @user = FactoryBot.create(:user, password: password, password_confirmation: password)
  login_as(@user, scope: :user)
  visit edit_profile_path(@user)
  expect(page).to have_button('Salvar Alterações')
end

Quando('confirmo a exclusão da conta') do
  accept_confirm do
    click_button 'Excluir conta'
  end
end

Então('devo ver a confirmação de conta excluída') do
  expect(page).to have_current_path(root_path)
  expect(page).to have_content('Conta excluída com sucesso.')
end

Então('minha conta deve ser removida do sistema') do
  expect(User.find_by(id: @user.id)).to be_nil
end

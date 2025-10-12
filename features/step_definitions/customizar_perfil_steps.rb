Dado('que estou logado como {string}') do |username|
  # Ensure user exists (this app stores display name in `name`) and sign in
  user = User.find_by(name: username)
  unless user
    user = User.create!(name: username, email: "#{username}@teste.com", password: 'password123')
  end
  # keep user available to later steps
  @current_user = user
  visit new_user_session_path
  fill_in 'Email', with: user.email
  # Devise login form may use localized labels. Try common Portuguese label then fallback to 'Password'.
  if page.has_field?('Senha')
    fill_in 'Senha', with: 'password123'
  else
    fill_in 'Password', with: 'password123'
  end
  # Try clicking localized button or English fallback
  if page.has_button?('Entrar')
    click_button 'Entrar'
  else
    click_button 'Log in'
  end
end

Dado('acesso a página de edição de perfil') do
  # edit_profile_path requires an id; use the user we logged in as
  visit edit_profile_path(@current_user)
end

Quando('altero meu nome de usuário para {string}') do |novo_nome|
  pending
end

Quando('salvo as alterações') do
  click_button 'Salvar'
end

Então('devo ver uma mensagem de sucesso') do
  expect(page).to have_content(/sucesso|atualizado/i)
end

Então('meu nome de usuário deve ser exibido como {string}') do |nome|
  pending
end

Quando('apago meu nome de usuário') do
  pending
end

Então('devo ver uma mensagem de erro indicando que o nome de usuário não pode ser em branco') do
  pending
end

Dado('que já existe um usuário com nome {string}') do |nome|
  User.create!(name: nome, email: "#{nome}@teste.com", password: 'password123')
end

Então('devo ver uma mensagem de erro indicando que o nome de usuário já está em uso') do
  expect(page).to have_content('Username has already been taken')
end
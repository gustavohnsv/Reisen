Dado('que estou logado como {string}') do |username|
  # Ensure user exists (this app stores display name in `name`) and sign in
  user = User.find_by(name: username)
  unless user
    user = FactoryBot.create(:user, name: username, email: "#{username}@teste.com", password: 'password123', password_confirmation: 'password123')
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
  # procurar campo por labels comuns (PT/EN) ou pelo atributo name
  field = ['Nome', 'Username', 'User name', 'Name'].find { |f| page.has_field?(f) }
  if field
    fill_in field, with: novo_nome, match: :first
  elsif page.has_selector?('input[name="user[name]"]')
    find('input[name="user[name]"]').set(novo_nome)
  else
    # se não encontrou o campo, lançar erro para facilitar debug
    raise "Campo de nome de usuário não encontrado para setar '#{novo_nome}'"
  end

  @new_username = novo_nome
end

Quando('salvo as alterações') do
  click_button 'Salvar'
end

Então('devo ver uma mensagem de sucesso') do
  expect(page).to have_content(/sucesso|atualizado/i)
end

Então('meu nome de usuário deve ser exibido como {string}') do |nome|
  # aguarda e verifica que o texto aparece em algum lugar da página
  expect(page).to have_content(nome)
end

Quando('apago meu nome de usuário') do
  field = ['Nome', 'Username', 'User name', 'Name'].find { |f| page.has_field?(f) }
  if field
    fill_in field, with: '', match: :first
  elsif page.has_selector?('input[name="user[name]"]')
    find('input[name="user[name]"]').set('')
  else
    raise 'Campo de nome de usuário não encontrado para limpar'
  end
end

Então('devo ver uma mensagem de erro indicando que o nome de usuário não pode ser em branco') do
  expect(page).to have_content(/não pode (?:ficar )?em branco|can'?t be blank|can't be blank/i)
end

Dado('que já existe um usuário com nome {string}') do |nome|
  FactoryBot.create(:user, name: nome, email: "#{nome}@teste.com", password: 'password123', password_confirmation: 'password123')
end

Então('devo ver uma mensagem de erro indicando que o nome de usuário já está em uso') do
  expect(page).to have_content(/já está em uso|já está em uso\.|has already been taken|already been taken|Name has already been taken/i)
end
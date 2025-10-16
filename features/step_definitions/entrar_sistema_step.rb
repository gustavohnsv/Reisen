Dado('que meu nome é {string}') do | name |
  @name = name
end

Dado('que meu email é {string}') do | email |
  @email = email
end

Dado('que minha senha é {string}') do | password |
  @password = password
end

Dado('que eu estou na página principal e não tenho uma conta') do
  visit root_path
  expect(current_path).to eq(root_path)
end

Quando('clicar em {string}') do |string|
  click_on string, match: :first
end

Então('devo ser redirecionado para a tela de cadastro') do
  expect(current_path).to eq(new_user_registration_path)
end

Quando('preencher o campo {string} com {string}') do |field, value|
  fill_in field, with: value
end

Então('minha conta deve ser criada') do
  @user = User.find_by(email: @email)
  expect(@user).to_not be_nil
end

Então('devo ser redirecionado para a tela de perfil') do
  expect(current_path).to eq(profile_path(@user.id))
end

Dado('que eu estou na página principal e tenho uma conta') do
  @user = User.create!(name: @name, email: @email, password: @password, password_confirmation: @password)
  expect(@user).to_not be_nil
  visit root_path
end

Então('devo ser redirecionado para a tela de login') do
  expect(current_path).to eq(new_user_session_path)
end

Quando('eu tento visitar a tela de perfil') do
  visit profile_path(1)
end

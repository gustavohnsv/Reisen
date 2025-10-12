Dado('que eu tenho uma conta e estou no meu perfil') do
  @user = User.create!(name: @name, email: @email, password: @password, password_confirmation: @password)
  expect(@user).to_not be_nil
  visit new_user_session_path
  fill_in "Email", with: @email
  fill_in "Password", with: @password
  click_button "Log in"
  expect(current_path).to eq(profile_path(@user.id))
end

Dado('que quero criar um roteiro chamado {string}') do | title |
  @title = title
end

Dado('que eu estou na página de perfil') do
  expect(current_path).to eq(profile_path(@user.id))
end

Então('devo ser redirecionado para a tela de criação de roteiro') do
  expect(current_path).to eq(new_script_path)
end

Então('meu roteiro deve ser criado') do
  @script = Script.find_by(title: @title)
  expect(@script).to_not be_nil
end

Então('devo ser redirecionado para a tela do novo documento') do
  expect(current_path).to eq(script_path(@script.id))
end
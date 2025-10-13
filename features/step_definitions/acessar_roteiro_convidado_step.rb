Dado('que existe um token para o roteiro {string} de {string}') do |title, name|
  @user = User.create!(name: name, email: "a@example.com", password: "123456", password_confirmation: "123456")
  expect(@user).to_not be_nil
  @script = @user.scripts.create!(title: title)
  expect(@script).to_not be_nil
  @script_token = @script.shareable_token
  expect(@script_token).to_not be_nil
end

Quando('eu visitar o link para o roteiro de {string}') do |string|
  visit script_url(@script, token: @script_token)
end

Então('devo ser redirecionado para a tela do roteiro de {string}') do |string|
  expect(current_url).to eq(script_url(@script, token: @script_token))
end

Quando('eu visitar o link para o roteiro de {string} sem o token') do |string|
  visit script_url(@script, token: 'fake_token')
end

Então('devo ser redirecionado para a página principal') do
  expect(current_path).to eq(root_path)
end
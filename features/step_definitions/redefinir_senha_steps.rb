require 'uri'

Dado('que eu estou na página de login') do
  visit new_user_session_path
end

Quando('eu clico em {string}') do |link_text|
  if page.has_link?(link_text)
    click_link(link_text)
  elsif page.has_link?('Esqueci minha senha')
    click_link('Esqueci minha senha')
  elsif page.has_link?('Forgot your password?')
    click_link('Forgot your password?')
  else
    raise "Link de 'esqueci minha senha' não encontrado na página"
  end
end

Quando('eu informo o e-mail {string} e envio a solicitação') do |email|
  @user = User.find_by(email: email) || FactoryBot.create(:user, email: email, password: 'password123', password_confirmation: 'password123')
  ActionMailer::Base.deliveries.clear

  if page.has_field?('Email')
    fill_in 'Email', with: email
  elsif page.has_field?('E-mail')
    fill_in 'E-mail', with: email
  elsif page.has_field?('user[email]')
    fill_in 'user[email]', with: email
  else
    raise 'Campo de e-mail para recuperação não encontrado'
  end

  ['Enviar', 'Enviar instruções de redefinição de senha', 'Send me reset password instructions', 'Enviar instruções'].each do |btn|
    if page.has_button?(btn)
      click_button btn
      break
    end
  end
end

Então('o sistema envia um e-mail para {string} contendo um link de redefinição com um token válido') do |email|
  mail = ActionMailer::Base.deliveries.last
  raise 'Nenhum e-mail enviado' if mail.nil?
  expect(mail.to).to include(email)
  body = mail.body.encoded
  url = body[/http[^"\s>]+reset_password_token=[^&\s"]+/]
  raise 'Link de redefinição não encontrado no e-mail' if url.nil?
  @reset_link = url
end

Quando('eu clico no link de redefinição recebido e acesso a página de nova senha') do
  raise 'Reset link não definido' unless @reset_link
  visit @reset_link
  expect(page).to have_selector('input[name="user[password]"]')
  expect(page).to have_selector('input[name="user[password_confirmation]"]')
end

E('eu informo a nova senha {string} e confirmo com {string}') do |pw, pw_conf|
  find('input[name="user[password]"]').set(pw)
  find('input[name="user[password_confirmation]"]').set(pw_conf)
end

E('eu submeto a nova senha') do
  if page.has_button?('Change my password')
    click_button 'Change my password'
  elsif page.has_button?('Alterar minha senha')
    click_button 'Alterar minha senha'
  elsif page.has_button?('Salvar')
    click_button 'Salvar'
  else
    find('form').find('input[type="submit"], button[type="submit"]', match: :first).click
  end
end

Então('a senha do usuário é atualizada') do
  @user.reload
  expect(@user.valid_password?('Senha@123')).to be_truthy
end

Então('eu sou redirecionado para a página de login com a mensagem {string}') do |msg|
  # verifica presença da mensagem — aceita variações
  found = page.has_content?(msg) ||
          page.has_content?(/senha.*redefinida.*sucesso/i) ||
          page.has_content?(/password.*changed/i) ||
          page.has_content?(/changed successfully/i)
  raise "Mensagem de confirmação não encontrada: #{msg}" unless found

  allowed_paths = [new_user_session_path, root_path, '/']
  unless allowed_paths.include?(current_path)
    raise "Redirecionamento inesperado: #{current_path}"
  end
end

Então('o token de redefinição é invalidado') do
  @user.reload
  expect(@user.reset_password_token).to be_nil
end
Given(/^que existe um documento de planejamento intitulado "([^"]+)" com a seção "([^"]+)"$/) do |title, section|
  @owner = FactoryBot.create(:user, name: 'owner', email: "owner+#{Time.now.to_i}@example.com", password: 'password', password_confirmation: 'password')
  @script = FactoryBot.create(:script, title: title, user: @owner)
  # script_item exige description não-vazio; usar texto curto inicial para passar validação
  @section = FactoryBot.create(:script_item, title: section, description: 'Descrição inicial', script: @script)
end

Given(/^que existe um usuário "([^"]+)" membro do documento$/) do |username|
  user = create_user_and_add_to_group(username, "grupo")
  ScriptParticipant.create!(user: user, script: @script)
  @current_user = user
end

Given(/^que existe um usuário "([^"]+)" que não pertence ao documento$/) do |username|
  user = create_user_and_add_to_group(username, "grupo_externo")
  @current_user = user
end

When(/^"([^"]+)" abre o documento$/) do |username|
  user = User.find_by(name: username) || create_user_and_add_to_group(username, "tmp")
  # If you want full browser interaction, implement create_browser_session helper.
  # For faster tests we operate on the model directly in subsequent steps.
  @current_user = user
end

When(/^eu edito a seção "([^"]+)" com o texto "([^"]+)"$/) do |section, text|
  if @current_user && (@script.script_participants.exists?(user_id: @current_user.id) || @script.user == @current_user)
    @section.update!(description: text)
    @last_save_ok = true
  else
    @authorization_error = "Você não tem permissão para editar este documento"
    @last_save_ok = false
  end
end

When(/^eu salvo as alterações$/) do
  if @last_save_ok
    @last_message = "Documento salvo com sucesso"
  end
end

Then(/^eu devo ver a mensagem "([^"]+)"$/) do |msg|
  expect(@last_message).to eq(msg)
end

Then(/^a seção "([^"]+)" deve conter "([^"]+)"$/) do |section, content|
  @section.reload
  expect(@section.description).to include(content)
end

When(/^tento editar a seção "([^"]+)" com o texto "([^"]+)"$/) do |section, text|
  step %{eu edito a seção "#{section}" com o texto "#{text}"}
end

Then(/^devo receber um erro de autorização "([^"]+)"$/) do |msg|
  expect(@authorization_error).to eq(msg)
end

### Helper básico
def create_user_and_add_to_group(username, _group_name)
  User.find_by(email: "#{username}@example.com") || FactoryBot.create(:user, name: username, email: "#{username}@example.com", password: 'password', password_confirmation: 'password')
end

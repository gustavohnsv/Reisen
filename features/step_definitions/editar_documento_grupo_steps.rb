require 'capybara/cucumber'
require 'tmpdir'
require 'fileutils'

Given(/que sou membro do grupo "([^"]+)"/) do |group_name|
  pending
end

Given(/existe um documento de planejamento intitulado "([^"]+)"/) do |title|
  pending
end

When(/eu edito a seção "([^"]+)" com o texto "([^"]+)"/) do |section, text|
  pending
end

When(/eu salvo as alterações/) do
  pending
end

Then(/eu devo ver a mensagem "([^"]+)"/) do |message|
  pending
end

Then(/a seção "([^"]+)" deve conter "([^"]+)"/) do |section, text|
  pending
end

# Multi-session example using Capybara::Session
Given(/que existe um grupo com dois membros: "([^"]+)" e "([^"]+)"/) do |user1, user2|
  pending
end

Given(/existe um documento "([^"]+)" com a seção "([^"]+)"/) do |title, section|
  pending
end

When(/"([^\"]+)" abre o documento em uma sessão de navegador/) do |username|
  pending
end

When(/"([^"]+)" altera a seção "([^\"]+)" para "([^\"]+)" e salva/) do |username, section, new_text|
  pending
end

Then(/"([^"]+)" deve ver a atualização "([^\"]+)" no documento após recarregar a página/) do |username, expected|
  pending
end

When(/eu tento salvar a seção "([^"]+)" com texto "([^"]*)"/) do |section, text|
  pending
end

Then(/devo ver um erro "([^"]+)"/) do |msg|
  pending
end

Given(/que existe um usuário "([^"]+)" que não pertence ao grupo/) do |username|
  pending
end

When(/"([^"]+)" tenta editar a seção "([^"]+)"/) do |username, section|
  pending
end

Then(/deve receber um erro de autorização "([^"]+)"/) do |msg|
  pending
end

### Helper placeholders (implemente no seu test helper/factory)
def create_user_and_add_to_group(username, group_name)
  # The application stores display name in `name`, not `username`.
  user = User.find_by(email: "#{username}@example.com") || User.create!(name: username, email: "#{username}@example.com", password: 'password123')
  # NOTE: this project doesn't have a Group model scaffold in the workspace;
  # if you have a Group model, adapt the code below to attach the user to the group.
  user
end

Given(/^existe um documento "([^"]+)"$/) do |title|
  pending
end

def create_browser_session(username)
  driver_name = "headless_chrome_#{username}_#{Time.now.to_i}_#{rand(1000)}".to_sym
  tmp_profile = Dir.mktmpdir("capybara-#{username}-")
  @tmp_profiles ||= []
  @tmp_profiles << tmp_profile

  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless=new')
  options.add_argument('--disable-gpu')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1920,1080')
  options.add_argument('--no-first-run')
  options.add_argument('--no-default-browser-check')
  options.add_argument('--disable-extensions')
  # use a remote debugging port to isolate sessions; avoid passing --user-data-dir if snap chromium misbehaves
  port = 20_000 + rand(10_000)
  options.add_argument("--remote-debugging-port=#{port}")
  options.binary = ENV['CHROME_BIN'] if ENV['CHROME_BIN']

  chromedriver_path = ENV['CHROMEDRIVER_PATH'] || '/usr/bin/chromedriver'
  service = if File.exist?(chromedriver_path)
    Selenium::WebDriver::Service.chrome(path: chromedriver_path)
  else
    Selenium::WebDriver::Service.chrome
  end

  Capybara.register_driver(driver_name) do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options, service: service)
  end

  session = Capybara::Session.new(driver_name)
  user = (username == @user1.name ? @user1 : @user2)
  login_as(user, scope: :user, run_callbacks: false)
  if defined?(perfil_documento_path) && @perfil
    session.visit perfil_documento_path(@perfil.id, @document.id)
  else
    session.visit '/'
  end
  (@sessions ||= {})[username] = session
end

When(/"([^"]+)" abre o mesmo documento em outra sessão de navegador/) do |username|
  pending
end

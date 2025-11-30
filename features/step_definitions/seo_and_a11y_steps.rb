# features/step_definitions/seo_steps.rb

Então('a página deve ter o título {string}') do |titulo|
  expect(page).to have_title(titulo)
end

Então('a página deve ter a meta tag {string} preenchida') do |name|
  expect(page).to have_css("meta[name='#{name}']", visible: false)
  meta = find("meta[name='#{name}']", visible: false)
  expect(meta[:content]).not_to be_empty
end

Então('a página deve ter a meta tag {string} contendo {string}') do |name, content|
  expect(page).to have_css("meta[name='#{name}']", visible: false)
  meta = find("meta[name='#{name}']", visible: false)
  expect(meta[:content]).to include(content)
end

Então('a página deve ter as tags Open Graph configuradas') do
  expect(page).to have_css("meta[property='og:title']", visible: false)
  expect(page).to have_css("meta[property='og:description']", visible: false)
  expect(page).to have_css("meta[property='og:image']", visible: false)
end

Dado('que eu estou na página inicial') do
  visit root_path
end

Dado('que existe um roteiro público com título {string}') do |titulo|
  # Assuming FactoryBot is set up, or use ActiveRecord
  # We need a user to own the script
  user = User.first || FactoryBot.create(:user)
  @script = FactoryBot.create(:script, title: titulo, user: user)
end

Quando('eu acesso a página desse roteiro') do
  visit script_path(@script, token: @script.shareable_token)
end



Dado('que eu acesso qualquer página pública') do
  visit root_path
end

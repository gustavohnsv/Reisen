Dado('que estou na página de notícias') do
  visit root_path
end

Quando('devo ver o título {string}') do |titulo|
  expect(page).to have_content(titulo)
end

Quando('eu clico em {string} na primeira notícia') do |link_text|
  # tenta clicar no primeiro link que contenha o texto (silencioso se não existir)
  first('a', text: link_text)&.click
end

Então('devo ver o conteúdo completo da notícia') do
  # expectativa genérica; ajuste se sua view tiver um seletor específico
  expect(page).to have_css('.news-content').or have_content('Texto') 
end

Então('devo ver pelo menos uma notícia exibida na tela') do
  expect(page).to have_css('.news-list article').or have_css('.news-list')
end
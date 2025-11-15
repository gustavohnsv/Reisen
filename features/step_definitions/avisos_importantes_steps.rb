Dado('que existe um aviso com o título {string} e o corpo {string} marcado como visível') do |titulo, corpo|
  # cria uma instância persistente no banco para a feature sem depender do FactoryBot
  FactoryBot.create(:notice, title: titulo, body: corpo, visible: true)
end

Então('devo ver um aviso com o texto {string}') do |texto|
  expect(page).to have_content(texto)
end

Então('devo ver o texto {string}') do |texto|
  expect(page).to have_content(texto)
end

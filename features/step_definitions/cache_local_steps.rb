Dado('que estou na página inicial') do
  visit root_path
end

Quando('acesso o roteiro rápido') do
  click_link 'Roteiro', match: :first
end

Então('devo ver o formulário de planejamento local') do
  expect(page).to have_css('[data-controller="roteiro"]')
  expect(page).to have_content('Roteiro rápido')
end

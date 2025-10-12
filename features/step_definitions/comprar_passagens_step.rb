Dado('que tenho um roteiro chamado {string}') do |string|
  @script = @user.scripts.create!(title: string)
  expect(@script).to_not be_nil
end

Quando('clicar no link {string}') do |string|
  click_link string
end

Dado('que existem companhias áreas com links de compra disponíveis') do
  expect(page).to have_selector('a[href^="/mock"]')
end

Quando('eu clico no link da companhia {string}') do |string|
  click_link string
end

Então('a nova aba da companhia {string} deve ser aberta e ter o URL validado') do |string|
  expect(current_path).to have_content(string.downcase)
end

Dado('que vejo um roteiro chamado {string}') do |string|
  expect(page).to have_link(string)
end

Então('devo ser redirecionado para o roteiro {string}') do |string|
  expect(current_path).to eq(script_path(@script.id))
end
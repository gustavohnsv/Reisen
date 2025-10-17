Dado('que tenho uma checklist chamada {string}') do |checklist_title|
  @checklist = FactoryBot.create(:checklist, title: checklist_title, user: @user)
  expect(@checklist).to_not be_nil
end

Dado('que estou na pagina da checklist {string}') do |string|
  excpect(current_path)
end

Dado('que eu estou na página da checklist {string}') do |string|
  expect(current_path).to eq(checklist_path(@checklist.id))
end

Dado('que vejo uma checklist chamada {string}') do |checklist_title|
  expect(page).to have_link(checklist_title)
end

Então('devo ser redirecionado para a checklist {string}') do |string|
  expect(current_path).to eq(checklist_path(@checklist.id))
end

Dado('que tenho um item da checklist chamado {string}') do |desc|
  @item = FactoryBot.create(:checklist_item, description: desc, checklist: @checklist)
end

Quando('preencher o campo com ID {string} do item da checklist {string} com {string}') do |id, checklist_title, desc|
  fill_in(id, with: desc)
end

Então('devo ver o item {string} na pagina da checklist {string} com o seu ID') do |desc, string2|
  @id = @checklist.checklist_items.find_by(description: desc).id
  expect(page).to have_field("edit-item-description_#{@id}", with: desc)
end

Dado('que vejo um item de checklist chamado {string} com o seu ID') do |desc|
  @id = @checklist.checklist_items.find_by(description: desc).id
  expect(page).to have_field("edit-item-description_#{@id}", with: desc)
end

Então('nao devo ver o item {string} na pagina da checklist {string} com o seu ID') do |desc, string2|
  @id = @checklist.checklist_items.find_by(description: desc)
  expect(@id).to be_nil
end

Quando('preencher o campo com ID {string} com o nome {string} para {string}') do |id, old_desc, new_desc|
  @id = @checklist.checklist_items.find_by(description: old_desc).id
  id = "#{id}_#{@id}"
  fill_in(id, with: new_desc)
end

Dado('sua caixa de seleçao nao esta marcada') do
  @checkbox_id = "edit-item-check_#{@item.id}"
  expect(find_field(@checkbox_id, type: 'checkbox')).to_not be_checked
end

Quando('clicar no checkbox do item da checklist chamado {string}') do |string|
  check(@checkbox_id)
end

Entao('sua caixa de seleçao deve estar marcada') do
  expect(find_field(@checkbox_id, type: 'checkbox')).to be_checked
end

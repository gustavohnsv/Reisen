Dado('que tenho um item do roteiro chamado {string}') do |title|
  @item = FactoryBot.create(:script_item, title: title, script: @script, user: @user)
end

Dado('que eu estou na página do roteiro {string}') do |string|
  expect(current_path).to eq(script_path(@script.id))
end

Quando('preencher o campo com ID {string} do item do roteiro {string} com {string}') do |id, script_title, value|
  if id == 'new-item-date-time-start'
    time = DateTime.new(DateTime.now.year, DateTime.now.month, DateTime.now.day, 12, 0, 0)
    formated_time = time.strftime('%Y-%m-%dT%H:%M')
    fill_in(id, with: formated_time)
  else
    fill_in(id, with: value)
  end
end

Então('devo ver o item {string} na página do roteiro {string} com o seu ID') do |title, script_title|
  @id = @script.script_items.find_by(title: title).id
  expect(page).to have_field("edit-item-title_#{@id}", with: title)
end

Dado('que vejo um item do roteiro chamado {string} com o seu ID') do |title|
  @id = @script.script_items.find_by(title: title).id
  expect(page).to have_field("edit-item-title_#{@id}", with: title)
end

Então('não devo ver o item {string} na página do roteiro {string} com o seu ID') do |title, script_title|
  @id = @script.script_items.find_by(title: title)
  expect(@id).to be_nil
end

Quando('preencher o campo do item do roteiro com ID {string} com o nome {string} para {string}') do |id, old_title, new_title|
  @id = @script.script_items.find_by(title: old_title).id
  id = "#{id}_#{@id}"
  fill_in(id, with: new_title)
end
Dado('que quero criar uma checklist chamada {string}') do |string|
  @title = string
end

Então('devo ser redirecionado para a tela de criação de checklist') do
  expect(current_path).to eq(new_checklist_path)
end

Então('minha checklist deve ser criada') do
  @checklist = Checklist.find_by(title: @title)
  expect(@checklist).not_to be_nil
end

Então('devo ser redirecionado para a tela da nova checklist') do
  expect(current_path).to eq(checklist_path(@checklist.id))
end
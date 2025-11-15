Quando('preencher o campo com ID {string} com {string}') do |id, value|
  if id == 'new-spend-date'
    time = Date.new(Date.current.year, Date.current.month, Date.current.day)
    formated_time = time.strftime('%Y-%m-%d')
    fill_in(id, with: formated_time)
  else
    fill_in(id, with: value)
  end
end

Quando('selecionar o campo com ID {string} com {string}') do |id, value|
  select value, from: id
end

Então('devo receber um código de resposta {string}') do |code|
  expect(page.status_code).to eq(code.to_i)
end
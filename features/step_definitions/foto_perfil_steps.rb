Quando('eu envio uma imagem de perfil') do
  path = Rails.root.join('spec', 'fixtures', 'files', 'sample.jpg')
  attach_file('user[avatar]', path, make_visible: true)
end

# Reuse the generic 'salvo as alterações' and success steps defined in customizar_perfil_steps.rb

Então('devo ver a pré-visualização da minha foto de perfil na página') do
  expect(page).to have_css('img')
end


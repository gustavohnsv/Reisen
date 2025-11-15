Quando('eu envio um arquivo não-imagem') do
  path = Rails.root.join('spec', 'fixtures', 'files', 'not_an_image.txt')
  attach_file('user[avatar]', path, make_visible: true)
end

Quando('eu envio uma imagem grande simulada') do
  # Create a temporary large file (~3MB) for testing
  large_path = Rails.root.join('tmp', 'test_large_image.jpg')
  unless File.exist?(large_path)
    File.open(large_path, 'wb') { |f| f.write('0' * 3 * 1024 * 1024) }
  end
  attach_file('user[avatar]', large_path, make_visible: true)
end

Então('devo ver uma mensagem de erro indicando que o arquivo deve ser uma imagem') do
  expect(page).to have_content(/imagem|formato/i)
end

Então('devo ver uma mensagem de erro indicando que o arquivo é muito grande') do
  expect(page).to have_content(/muito grande|tamanho/i)
end

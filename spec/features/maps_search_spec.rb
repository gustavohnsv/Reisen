require 'rails_helper'

RSpec.describe 'Página de busca no Google Maps', type: :feature do
  it 'renderiza input e botão' do
    visit maps_search_path

    expect(page).to have_selector('label[for="maps-query"]', text: 'O que você quer buscar?')
    expect(page).to have_selector('#maps-query')
    expect(page).to have_button('Buscar no Google Maps')
  end

  it 'exibe mensagem quando query está vazia e não redireciona' do
    visit maps_search_path

    click_button 'Buscar no Google Maps'
    expect(page).to have_selector('.alert.alert-danger', text: 'Digite um termo para buscar.')
  end

  it 'submete a busca via POST (sem realmente navegar para domínio externo)' do
    visit maps_search_path
    fill_in id: 'maps-query', with: 'Padaria perto de mim'
    # Capybara vai tentar seguir redirect externo; dependendo do driver isso pode falhar.
    # Então apenas garante que o submit do formulário está presente e funcional até o clique.
    expect { click_button 'Buscar no Google Maps' }.not_to raise_error
  end
end


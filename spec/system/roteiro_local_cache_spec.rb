require 'rails_helper'

RSpec.describe 'Roteiro rápido (cache local)', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'permite visitante acessar o roteiro rápido e visualizar o formulário' do
    visit root_path
    click_link 'Roteiro', match: :first

    expect(page).to have_current_path(roteiro_path)
    expect(page).to have_css('[data-controller="roteiro"]')
    expect(page).to have_field('roteiro-title')
    expect(page).to have_button('Salvar item')
  end
end

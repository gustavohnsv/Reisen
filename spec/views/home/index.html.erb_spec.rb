require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do
  before do
    render
  end

  it 'exibe o título do projeto' do
    expect(rendered).to include('Reisen')
  end

  #it 'exibe o subtítulo' do
  #  expect(rendered).to include('Planejador de Viagens Colaborativo')
  #end

  #it 'exibe mensagem de boas-vindas' do
  #  expect(rendered).to include('Bem-vindo')
  #end
end

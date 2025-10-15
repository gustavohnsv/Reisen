require 'rails_helper'

RSpec.describe "scripts/show.html.erb", type: :view do

  let!(:user) {FactoryBot.create(:user)}
  let!(:script) {FactoryBot.create(:script, user: user)}

  let(:mocked_airlines) do
    {
      "Latam" => "/mock/latam",
      "Gol"   => "/mock/gol",
      "Azul"  => "/mock/azul"
    }
  end

  before(:each) do
    assign(:user, user)
    assign(:script, script)
    assign(:airlines, mocked_airlines)
    render
  end

  it 'deve conter o nome do roteiro' do
    expect(rendered).to have_content(script.title)
  end
  it 'deve conter o proprietário do roteiro' do
    expect(rendered).to have_content(user.name)
  end
  it 'deve conter um botão para copiar o link de compartilhamento' do
    expect(rendered).to have_button('Copiar link de compartilhamento')
  end
  it 'deve conter pelo menos um link para uma companhia área' do
    expect(rendered).to have_selector('a[href^="/mock"]')
  end
end

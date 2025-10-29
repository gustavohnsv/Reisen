require 'rails_helper'

RSpec.describe "scripts/show.html.erb", type: :view do

  let!(:user) {FactoryBot.create(:user)}
  let!(:script) {FactoryBot.create(:script, user: user)}
  let!(:item) {FactoryBot.build(:script_item, script: script)}

  let(:mocked_airlines) do
    {
      "Latam" => "/mock/latam",
      "Gol"   => "/mock/gol",
      "Azul"  => "/mock/azul"
    }
  end

  context 'usuário está logado' do
    before(:each) do
      assign(:user, user)
      assign(:script, script)
      assign(:item, item)
      assign(:airlines, mocked_airlines)
      allow(view).to receive(:current_user).and_return(user)
      render
    end

    it 'deve conter o nome do roteiro' do
      expect(rendered).to have_field("edit-title", with: script.title)
    end
    it 'deve conter o proprietário do roteiro' do
      expect(rendered).to have_content(user.name)
    end
    it 'deve conter um botão para copiar o link de compartilhamento' do
      expect(rendered).to have_selector('button', text: 'Copiar Link')
    end
    it 'deve conter pelo menos um link para uma companhia área' do
      expect(rendered).to have_selector('a[href^="/mock"]')
    end
  end

end

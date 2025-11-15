require 'rails_helper'

RSpec.describe "scripts/show.html.erb", type: :view do

  let!(:user) {FactoryBot.create(:user)}
  let!(:script) {FactoryBot.create(:script, user: user)}
  let!(:item) {FactoryBot.build(:script_item, script: script)}
  let!(:spend) {FactoryBot.build(:script_spend, script: script)}

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
      assign(:spend, spend)
      assign(:owner, user)
      assign(:participants, [])
      assign(:grouped_items, {})
      assign(:airlines, mocked_airlines)
      assign(:permission_level, :owner)
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

  context 'botão do Google Maps' do
    before(:each) do
      assign(:user, user)
      assign(:script, script)
      assign(:item, item)
      assign(:spend, spend)
      assign(:owner, user)
      assign(:participants, [])
      assign(:airlines, mocked_airlines)
      assign(:permission_level, :owner)
      allow(view).to receive(:current_user).and_return(user)
    end

    context 'quando há itens com localização' do
      before(:each) do
        item1 = FactoryBot.create(:script_item, script: script, location: 'Paris, França', date_time_start: DateTime.now)
        item2 = FactoryBot.create(:script_item, script: script, location: 'Lyon, França', date_time_start: DateTime.now + 1.day)
        assign(:grouped_items, script.script_items.order(date_time_start: :asc).group_by { |item| item.date_time_start&.to_date })
        allow(view).to receive(:google_maps_directions_url).and_return('https://www.google.com/maps/dir/?api=1&origin=Paris&destination=Lyon')
        render
      end

      it 'deve exibir o botão "Ver Rota no Google Maps"' do
        expect(rendered).to have_link('Ver Rota no Google Maps')
      end

      it 'deve ter o ícone directions' do
        expect(rendered).to have_selector('a[href*="google.com/maps"] i.material-icons', text: 'directions')
      end

      it 'deve abrir em nova aba' do
        expect(rendered).to have_selector('a[href*="google.com/maps"][target="_blank"]')
      end

      it 'deve ter rel="noopener noreferrer"' do
        expect(rendered).to have_selector('a[href*="google.com/maps"][rel="noopener noreferrer"]')
      end
    end

    context 'quando não há itens com localização' do
      before(:each) do
        assign(:grouped_items, {})
        allow(view).to receive(:google_maps_directions_url).and_return(nil)
        render
      end

      it 'não deve exibir o botão "Ver Rota no Google Maps"' do
        expect(rendered).not_to have_link('Ver Rota no Google Maps')
      end
    end

    context 'quando há apenas itens sem localização' do
      before(:each) do
        item = FactoryBot.create(:script_item, script: script, date_time_start: DateTime.now)
        item.update_column(:location, '')  # update_column bypassa validações
        assign(:grouped_items, script.script_items.order(date_time_start: :asc).group_by { |item| item.date_time_start&.to_date })
        allow(view).to receive(:google_maps_directions_url).and_return(nil)
        render
      end

      it 'não deve exibir o botão "Ver Rota no Google Maps"' do
        expect(rendered).not_to have_link('Ver Rota no Google Maps')
      end
    end
  end

end

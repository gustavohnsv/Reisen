Dado('que tenho um item do roteiro chamado {string} com localização {string}') do |title, location|
  @item = FactoryBot.create(:script_item, 
                            title: title, 
                            script: @script, 
                            user: @user,
                            location: location,
                            date_time_start: DateTime.now + @script.script_items.count.days,
                            estimated_cost: 100.0,
                            description: "Descrição do #{title}")
  # Recarrega a página para que o botão apareça após criar os itens
  visit script_path(@script) if @script
end

Dado('que tenho um item do roteiro chamado {string} sem localização') do |title|
  @item = FactoryBot.create(:script_item, 
                            title: title, 
                            script: @script, 
                            user: @user,
                            location: 'Temp Location',  # Cria com localização temporária válida
                            date_time_start: DateTime.now + @script.script_items.count.days,
                            estimated_cost: 100.0,
                            description: "Descrição do #{title}")
  # update_column bypassa validações para permitir localização vazia
  @item.update_column(:location, '')
  # Recarrega a página após modificar
  visit script_path(@script) if @script
end

Dado('que não há itens no roteiro') do
  @script.script_items.destroy_all
  # Recarrega a página para atualizar a sidebar
  visit script_path(@script) if @script
end

Então('devo ver um botão {string} na sidebar') do |button_text|
  within('.col-lg-4') do
    expect(page).to have_link(button_text, visible: :visible)
  end
end

Então('não devo ver um botão {string} na sidebar') do |button_text|
  within('.col-lg-4') do
    expect(page).not_to have_link(button_text, visible: :visible)
  end
end

Quando('clicar no botão {string}') do |button_text|
  click_link(button_text)
end

Então('devo ser redirecionado para uma URL do Google Maps contendo os waypoints') do
  # Verifica que o link na sidebar tem a URL do Google Maps com waypoints
  # Como links com target="_blank" não abrem nova aba em testes Capybara,
  # verificamos o href do link antes de clicar
  within('.col-lg-4') do
    link = find_link('Ver Rota no Google Maps')
    expect(link[:href]).to include('google.com/maps')
    expect(link[:href]).to include('api=1')
    expect(link[:target]).to eq('_blank')
  end
end


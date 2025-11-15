require 'rails_helper'

RSpec.describe ScriptsHelper, type: :helper do
  let(:user) { FactoryBot.create(:user) }
  let(:script) { FactoryBot.create(:script, user: user) }

  describe '#google_maps_directions_url' do
    context 'quando não há itens com localização' do
      it 'retorna nil quando não há itens' do
        expect(helper.google_maps_directions_url(script)).to be_nil
      end

      it 'retorna nil quando há apenas itens sem localização' do
        item = FactoryBot.create(:script_item, script: script, date_time_start: DateTime.now)
        item.update_column(:location, '')  # update_column bypassa validações
        expect(helper.google_maps_directions_url(script)).to be_nil
      end

      it 'retorna nil quando há apenas itens com localização nil' do
        item = FactoryBot.create(:script_item, script: script, date_time_start: DateTime.now)
        item.update_column(:location, nil)  # update_column bypassa validações
        expect(helper.google_maps_directions_url(script)).to be_nil
      end
    end

    context 'quando há 1 item com localização' do
      it 'retorna URL de search do Google Maps' do
        FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'Paris, França',
                         date_time_start: DateTime.now)
        
        url = helper.google_maps_directions_url(script)
        expect(url).to include('google.com/maps/search')
        expect(url).to include('api=1')
        expect(url).to include('query=')
        expect(url).to include(ERB::Util.url_encode('Paris, França'))
      end
    end

    context 'quando há 2 itens com localização' do
      it 'retorna URL de directions do Google Maps com origin e destination' do
        FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'Paris, França',
                         date_time_start: DateTime.now)
        FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'Lyon, França',
                         date_time_start: DateTime.now + 1.day)
        
        url = helper.google_maps_directions_url(script)
        expect(url).to include('google.com/maps/dir')
        expect(url).to include('api=1')
        expect(url).to include('origin=')
        expect(url).to include('destination=')
        expect(url).to include('travelmode=driving')
        expect(url).to include(ERB::Util.url_encode('Paris, França'))
        expect(url).to include(ERB::Util.url_encode('Lyon, França'))
      end
    end

    context 'quando há 3 ou mais itens com localização' do
      it 'retorna URL de directions com waypoints' do
        FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'Paris, França',
                         date_time_start: DateTime.now)
        FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'Lyon, França',
                         date_time_start: DateTime.now + 1.day)
        FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'Marselha, França',
                         date_time_start: DateTime.now + 2.days)
        
        url = helper.google_maps_directions_url(script)
        expect(url).to include('google.com/maps/dir')
        expect(url).to include('api=1')
        expect(url).to include('origin=')
        expect(url).to include('destination=')
        expect(url).to include('waypoints=')
        expect(url).to include('travelmode=driving')
        expect(url).to include(ERB::Util.url_encode('Paris, França'))
        expect(url).to include(ERB::Util.url_encode('Marselha, França'))
      end

      it 'ordena itens por date_time_start' do
        item2 = FactoryBot.create(:script_item, 
                                  script: script, 
                                  location: 'Item 2',
                                  date_time_start: DateTime.now + 2.days)
        item1 = FactoryBot.create(:script_item, 
                                  script: script, 
                                  location: 'Item 1',
                                  date_time_start: DateTime.now)
        item3 = FactoryBot.create(:script_item, 
                                  script: script, 
                                  location: 'Item 3',
                                  date_time_start: DateTime.now + 4.days)
        
        url = helper.google_maps_directions_url(script)
        
        # Origin deve ser o primeiro item (Item 1)
        origin_index = url.index('origin=')
        destination_index = url.index('destination=')
        waypoints_index = url.index('waypoints=')
        
        origin_part = url[origin_index..(destination_index || waypoints_index || url.length)]
        expect(origin_part).to include(ERB::Util.url_encode('Item 1'))
        
        # Destination deve ser o último item (Item 3)
        if destination_index
          destination_part = url[destination_index..url.length]
          expect(destination_part).to include(ERB::Util.url_encode('Item 3'))
        end
      end

      it 'ignora itens sem localização' do
        FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'Paris, França',
                         date_time_start: DateTime.now)
        item_sem_localizacao = FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'Temp Location',
                         date_time_start: DateTime.now + 1.day)
        item_sem_localizacao.update_column(:location, '')  # update_column bypassa validações
        FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'Lyon, França',
                         date_time_start: DateTime.now + 2.days)
        
        url = helper.google_maps_directions_url(script)
        # Deve ter apenas 2 itens (Paris e Lyon), não o item vazio
        expect(url).to include(ERB::Util.url_encode('Paris, França'))
        expect(url).to include(ERB::Util.url_encode('Lyon, França'))
        expect(url).not_to include('waypoints=') # Com apenas 2 itens válidos, não deve ter waypoints
      end
    end

    context 'URL encoding' do
      it 'faz encoding correto de caracteres especiais' do
        FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'São Paulo, SP, Brasil',
                         date_time_start: DateTime.now)
        
        url = helper.google_maps_directions_url(script)
        expect(url).to include(ERB::Util.url_encode('São Paulo, SP, Brasil'))
      end

      it 'faz encoding correto de caracteres com espaços' do
        FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'New York, NY, USA',
                         date_time_start: DateTime.now)
        
        url = helper.google_maps_directions_url(script)
        expect(url).to include(ERB::Util.url_encode('New York, NY, USA'))
      end

      it 'faz encoding correto de caracteres especiais em múltiplos itens' do
        FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'São Paulo, SP',
                         date_time_start: DateTime.now)
        FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'Rio de Janeiro, RJ',
                         date_time_start: DateTime.now + 1.day)
        
        url = helper.google_maps_directions_url(script)
        expect(url).to include(ERB::Util.url_encode('São Paulo, SP'))
        expect(url).to include(ERB::Util.url_encode('Rio de Janeiro, RJ'))
      end
    end

    context 'com 4 ou mais itens' do
      it 'retorna URL com waypoints quando há 4 itens' do
        FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'Paris, França',
                         date_time_start: DateTime.now)
        FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'Lyon, França',
                         date_time_start: DateTime.now + 1.day)
        FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'Marselha, França',
                         date_time_start: DateTime.now + 2.days)
        FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'Nice, França',
                         date_time_start: DateTime.now + 3.days)
        
        url = helper.google_maps_directions_url(script)
        expect(url).to include('google.com/maps/dir')
        expect(url).to include('api=1')
        expect(url).to include('origin=')
        expect(url).to include('destination=')
        expect(url).to include('waypoints=')
        expect(url).to include('travelmode=driving')
        expect(url).to include(ERB::Util.url_encode('Paris, França'))
        expect(url).to include(ERB::Util.url_encode('Nice, França'))
      end

      it 'retorna waypoints na ordem correta para 4 itens' do
        FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'Origem',
                         date_time_start: DateTime.now)
        FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'Waypoint1',
                         date_time_start: DateTime.now + 1.day)
        FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'Waypoint2',
                         date_time_start: DateTime.now + 2.days)
        FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'Destino',
                         date_time_start: DateTime.now + 3.days)
        
        url = helper.google_maps_directions_url(script)
        
        # Origin deve ser "Origem"
        expect(url).to match(/origin=.*#{ERB::Util.url_encode('Origem')}/)
        
        # Destination deve ser "Destino"
        expect(url).to match(/destination=.*#{ERB::Util.url_encode('Destino')}/)
        
        # Waypoints devem conter Waypoint1 e Waypoint2
        waypoints_match = url.match(/waypoints=(.*?)(?:&|$)/)
        expect(waypoints_match).not_to be_nil
        waypoints = waypoints_match[1]
        expect(waypoints).to include(ERB::Util.url_encode('Waypoint1'))
        expect(waypoints).to include(ERB::Util.url_encode('Waypoint2'))
      end
    end

    context 'com múltiplos itens misturados (com e sem localização)' do
      it 'filtra corretamente itens sem localização' do
        FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'Paris, França',
                         date_time_start: DateTime.now)
        
        item_vazio1 = FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'Temp',
                         date_time_start: DateTime.now + 1.day)
        item_vazio1.update_column(:location, '')
        
        FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'Lyon, França',
                         date_time_start: DateTime.now + 2.days)
        
        item_nil = FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'Temp',
                         date_time_start: DateTime.now + 3.days)
        item_nil.update_column(:location, nil)
        
        FactoryBot.create(:script_item, 
                         script: script, 
                         location: 'Marselha, França',
                         date_time_start: DateTime.now + 4.days)
        
        url = helper.google_maps_directions_url(script)
        
        # Deve ter apenas os 3 itens válidos
        expect(url).to include(ERB::Util.url_encode('Paris, França'))
        expect(url).to include(ERB::Util.url_encode('Lyon, França'))
        expect(url).to include(ERB::Util.url_encode('Marselha, França'))
        
        # Não deve ter waypoints porque após filtrar há exatamente 3 itens
        # (origin + destination + 1 waypoint)
        expect(url).to include('waypoints=')
      end
    end
  end
end

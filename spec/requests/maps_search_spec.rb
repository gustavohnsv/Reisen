require 'rails_helper'

RSpec.describe 'MapsSearch redirect', type: :request do
  describe 'POST /maps/search' do
    it 'redireciona para a URL do Google Maps com query codificada' do
      post maps_search_submit_path, params: { query: 'Padaria perto de mim' }
      expect(response).to have_http_status(:found)
      expect(response.headers['Location']).to eq('https://www.google.com/maps/search/?api=1&query=Padaria+perto+de+mim')
    end

    it 'codifica corretamente acentos e caracteres especiais' do
      post maps_search_submit_path, params: { query: 'Açaí & Café' }
      expect(response).to have_http_status(:found)
      expect(response.headers['Location']).to eq('https://www.google.com/maps/search/?api=1&query=A%C3%A7a%C3%AD+%26+Caf%C3%A9')
    end

    it 'renderiza novamente a página com status 422 quando vazio' do
      post maps_search_submit_path, params: { query: '' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end


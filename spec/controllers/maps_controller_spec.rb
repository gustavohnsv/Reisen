require 'rails_helper'

RSpec.describe MapsController, type: :controller do
  describe 'GET #search' do
    it 'renderiza a página de busca' do
      get :search
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:search)
    end
  end
  describe 'POST #submit' do
    it 'redireciona para a URL do Google Maps quando query é válida' do
      post :submit, params: { query: 'Padaria perto de mim' }
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to('https://www.google.com/maps/search/?api=1&query=Padaria+perto+de+mim')
    end

    it 'renderiza :search com 422 e flash quando query é vazia' do
      post :submit, params: { query: '' }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:search)
      expect(flash.now[:alert]).to eq('Digite um termo para buscar.')
    end
  end
end


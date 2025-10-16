require 'rails_helper'

RSpec.describe NewsController, type: :controller do
  describe 'GET #index' do
    context 'quando location é fornecido' do
      let(:location) { 'Lisboa' }
      let(:fake_news) do
        [
          {
            title: 'Melhores pontos turísticos de Lisboa',
            link: 'https://exemplo.com/noticia-1',
            description: 'Descubra os melhores lugares para visitar',
            pubDate: '2025-03-13 07:00:00 UTC'
          },
          {
            title: 'Guia de viagem: Lisboa',
            link: 'https://exemplo.com/noticia-2',
            description: 'Um guia completo para sua viagem',
            pubDate: '2025-04-07 07:00:00 UTC'
          },
          {
            title: 'Turismo em Lisboa cresce 20%',
            link: 'https://exemplo.com/noticia-3',
            description: 'Setor turístico em expansão',
            pubDate: '2025-03-13 07:00:00 UTC'
          }
        ]
      end

      before do
        # Mock do GoogleNewsService
        allow(GoogleNewsService).to receive(:fetch)
          .with(location: location)
          .and_return(fake_news)
      end

      it 'chama o GoogleNewsService com a localização correta' do
        get :index, params: { location: location }
        
        expect(GoogleNewsService).to have_received(:fetch).with(location: location)
      end

      it 'atribui as notícias à variável @news' do
        get :index, params: { location: location }
        
        expect(assigns(:news)).to eq(fake_news)
      end

      it 'renderiza o template index' do
        get :index, params: { location: location }
        
        expect(response).to render_template(:index)
      end

      it 'retorna status 200 OK' do
        get :index, params: { location: location }
        
        expect(response).to have_http_status(:ok)
      end
    end

    context 'quando location NÃO é fornecido' do
      let(:fake_news_generic) do
        [
          {
            title: 'Notícias sobre turismo',
            link: 'https://exemplo.com/noticia-geral-1',
            description: 'Turismo em alta temporada',
            pubDate: '2025-03-13 07:00:00 UTC'
          }
        ]
      end

      before do
        # Mock do GoogleNewsService sem location específica
        allow(GoogleNewsService).to receive(:fetch)
          .with(location: nil)
          .and_return(fake_news_generic)
      end

      it 'chama o GoogleNewsService com location nil' do
        get :index
        
        expect(GoogleNewsService).to have_received(:fetch).with(location: nil)
      end

      it 'atribui as notícias à variável @news' do
        get :index
        
        expect(assigns(:news)).to eq(fake_news_generic)
      end

      it 'renderiza o template index' do
        get :index
        
        expect(response).to render_template(:index)
      end

      it 'retorna status 200 OK' do
        get :index
        
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
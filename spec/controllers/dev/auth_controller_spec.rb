require 'rails_helper'

RSpec.describe Dev::AuthController, type: :controller do
  describe 'GET #login_as' do
    let!(:user) { create(:user) }


    context 'quando NÃO está em ambiente de desenvolvimento' do
      it 'retorna 404 (not_found)' do
        allow(Rails.env).to receive(:development?).and_return(false)
        get :login_as, params: { id: user.id }
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'quando está em ambiente de desenvolvimento' do
      it 'loga como o usuário e redireciona para a tela inicial (perfil)' do
        allow(Rails.env).to receive(:development?).and_return(true)
        get :login_as, params: { id: user.id }
        expect(response).to redirect_to(profile_path(user))
        # current_user helper disponível em controller specs via Devise helpers
        expect(controller.current_user).to eq(user)
        expect(flash[:notice]).to include('Logado como')
      end

      it 'redireciona para root se o usuário não existir' do
        allow(Rails.env).to receive(:development?).and_return(true)
        get :login_as, params: { id: 999_999 }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('Usuário não encontrado')
      end
    end
  end
end

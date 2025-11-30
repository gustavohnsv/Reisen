require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  let(:user) { create(:user) }

  describe 'GET /profiles/:id' do
    context 'usuário está logado' do
      before do
        sign_in(user)
      end
      it 'acessa o perfil com sucesso' do
        get profile_path(user.id)
        expect(response).to have_http_status(:success)
        expect(response.body).to include(user.name)
      end
      it 'acessa o perfil de outro usuário' do
        other = create(:user)
        get profile_path(other.id)
        expect(response).to redirect_to(root_path)
      end
    end
    context 'usuário não está logado' do
      it 'redireciona para a página de login' do
        get profile_path(user.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context 'usuário está logado e tenta buscar por um ID que não existe' do
      before do
        sign_in(user)
      end
      it 'redireciona para a página perfil' do
        non_existing_ID = 99999
        get profile_path(non_existing_ID)
        expect(response).to redirect_to(root_path)
      end
    end
    context 'usuário não está logado e tenta buscar por um ID que não existe' do
      it 'redireciona para a página inicial' do
        non_existing_ID = 99999
        get profile_path(non_existing_ID)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
  describe 'GET /my_profile' do
    context 'usuário está logado' do
      before do
        sign_in(user)
      end
      it 'redireciona para a página de perfil' do
        get my_profile_path
        expect(response).to redirect_to(profile_path(user.id))
      end
    end
  end

  describe 'GET /profiles/:id/edit' do
    context 'usuário está logado' do
      before do
        sign_in(user)
      end
      it 'usuário deve ser igual ao usuário da sessão' do
        get edit_profile_path(user.id)
        expect(response).to have_http_status(:success)
      end
    end
  end
end

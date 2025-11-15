require 'rails_helper'

RSpec.describe "UsersController", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }

  describe 'GET /users/:id/edit' do
    it 'redireciona para login quando não autenticado' do
      get edit_user_path(user)
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'bloqueia acesso a edição de outro usuário' do
      sign_in user
      get edit_user_path(other_user)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Acesso negado')
    end
  end

  describe 'PATCH /users/:id' do
    before { sign_in user }

    it 'atualiza sem exigir senha quando campos de senha estão vazios' do
      patch user_path(user), params: { user: { name: 'Nome Atualizado', password: '', password_confirmation: '' } }
      expect(response).to redirect_to(profile_path(user))
      expect(user.reload.name).to eq('Nome Atualizado')
    end

    it 'renderiza edição com 422 quando inválido' do
      patch user_path(user), params: { user: { email: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template('profiles/edit')
    end
  end
end

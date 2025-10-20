require 'rails_helper'

RSpec.describe "Checklists", type: :request do

  let!(:user) {FactoryBot.create(:user)}
  let!(:checklist) {FactoryBot.create(:checklist, user: user)}

  describe 'GET /checklists/:id' do
    context 'usuário está logado' do
      before do
        sign_in(user)
      end
      it 'acessa a checklist com sucesso' do
        get checklist_path(checklist.id)
        expect(response).to have_http_status(:success)
        expect(response.body).to include(checklist.title)
      end
      it 'não acessa a checklist de outro usuário' do
        other_user = FactoryBot.create(:user)
        other_checklist = FactoryBot.create(:checklist, user: other_user)
        get checklist_path(other_checklist.id)
        expect(response).to redirect_to(root_path)
      end
    end
    context 'usuário não está logado' do
      it 'não acessa a checklist' do
        get checklist_path(checklist.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
  describe 'PATCH /checklists/:id' do
    context 'usuário está logado' do
      before do
        sign_in(user)
      end
      it 'atualiza apenas o título da checklist com sucesso' do
        patch checklist_path(checklist.id), params: {checklist: {title: 'Checklist atualizada'}}
        expect(checklist.reload.title).to eq('Checklist atualizada')
        expect(response).to redirect_to(checklist_path(checklist.id))
      end
      it 'não atualiza o título da checklist' do
        patch checklist_path(checklist.id), params: {checklist: {title: ''}}
        expect(response).to have_http_status(:unprocessable_content)
        #expect(response).to render_template(:edit)
      end
    end
  end
  describe 'GET /checklists/:id/new' do
    context 'usuário está logado' do
      before do
        sign_in(user)
      end
      it 'a checklist é instanciada com sucesso' do
        get new_checklist_path
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:new)
        expect(assigns(:checklist)).to be_a_new(Checklist)
      end
    end
  end
  describe 'POST /checklists/' do
    context 'usuário está logado' do
      before do
        sign_in(user)
      end
      it 'a checklist é criada com sucesso' do
        expect {
          post checklists_path, params: {checklist: {title: 'Nova Checklist'}}
        }.to change(Checklist, :count).by(1)
        expect(response).to redirect_to(checklist_path(Checklist.last&.id))
      end
      it 'a checklist não é criada' do
        expect {
          post checklists_path, params: {checklist: {title: ''}}
        }.to change(Checklist, :count).by(0)
        expect(response).to render_template(:new)
      end
    end
  end
  #describe 'GET /checklists/:id/edit' do -> 'edit' substituída para uma partial
  #  context 'usuário está logado' do
  #    before do
  #      sign_in(user)
  #    end
  #    it 'acessa a página de edição de checklist com sucesso' do
  #      get edit_checklist_path(checklist.id)
  #      expect(response).to have_http_status(:success)
  #      expect(response).to render_template(:edit)
  #    end
  #  end
  #end
  describe 'DELETE /checklists/:id' do
    context 'usuário está logado' do
      before do
        sign_in(user)
      end
      it 'deleta a checklist com sucesso' do
        expect {
          delete checklist_path(checklist.id)
        }.to change(Checklist, :count).by(-1)
        expect(response).to redirect_to(root_path)
      end
    end
  end

end

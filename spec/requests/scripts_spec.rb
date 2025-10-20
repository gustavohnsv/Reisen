require 'rails_helper'

RSpec.describe "Scripts", type: :request do

  let!(:user) {FactoryBot.create(:user)}
  let!(:script) {FactoryBot.create(:script, user: user)}

  describe 'GET /scripts/:id' do
    context 'usuário está logado' do
      before do
        sign_in(user)
      end
      it 'há companhias áreas e links disponíveis' do
        get script_path(script.id)
        expect(assigns(:airlines)).to_not be_nil
      end
      it 'acessa o roteiro com sucesso' do
        get script_path(script.id)
        expect(response).to have_http_status(:success)
        expect(response.body).to include(script.title)
      end
      it 'acessa o roteiro de outro usuário e é participante' do
        other_user = FactoryBot.create(:user)
        other_script = FactoryBot.create(:script, user: other_user)
        FactoryBot.create(:participant, user: user, script: other_script)
        get script_path(other_script.id)
        expect(response).to have_http_status(:success)
        expect(response.body).to include(other_script.title)
      end
      it 'não acessa o roteiro de outro usuário pois não é participante' do
        other_user = FactoryBot.create(:user)
        other_script = FactoryBot.create(:script, user: other_user)
        get script_path(other_script.id)
        expect(response).to redirect_to(root_path)
      end
    end
    context 'usuário não está logado' do
      it 'acessa o roteiro com sucesso com token válido' do
        get script_url(script, token: script.shareable_token)
        expect(response).to have_http_status(:success)
        expect(response.body).to include(script.title)
      end
      it 'não acessa o roteiro pois token é inválido' do
        get script_url(script, token: 'fake_token')
        expect(response).to redirect_to(root_path)
      end
    end
  end
  describe 'PATCH /scripts/:id' do
    context 'usuário está logado' do
      before do
        sign_in(user)
      end
      it 'atualiza apenas o título do roteiro com sucesso' do
        patch script_path(script.id), params: {script: {title: 'Roteiro atualizado'}}
        expect(script.reload.title).to eq('Roteiro atualizado')
        expect(response).to redirect_to(script_path(script.id))
      end
      it 'não atualiza o título do roteiro' do
        patch script_path(script.id), params: {script: {title: ''}}
        expect(response).to have_http_status(:unprocessable_content)
        #expect(response).to render_template(:edit)
      end
      it 'não atualiza o título do roteiro pois não é o proprietário' do
        other_user = FactoryBot.create(:user)
        other_script = FactoryBot.create(:script, user: other_user)
        FactoryBot.create(:participant, user: user, script: other_script)
        patch script_path(other_script.id), params: {script: {title: 'Roteiro atualizado'}}
        expect(response).to redirect_to(root_path)
      end
    end
  end
  describe 'GET /scripts/new' do
    context 'usuário está logado' do
      before do
        sign_in(user)
      end
      it 'o roteiro é instanciado com sucesso' do
        get new_script_path
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:new)
        expect(assigns(:script)).to be_a_new(Script)
      end
    end
  end
  describe 'POST /scripts' do
    context 'usuário está logado' do
      before do
        sign_in(user)
      end
      it 'o roteiro é criado com sucesso' do
        expect {
          post scripts_path, params: {script: {title: 'Novo roteiro'}}
        }.to change(Script, :count).by(1)
        expect(response).to redirect_to(script_path(Script.last&.id))
      end
      it 'o roteiro não é criado' do
        expect {
          post scripts_path, params: {script: {title: ''}}
        }.to change(Script, :count).by(0)
        expect(response).to render_template(:new)
      end
    end
  end
  #describe 'GET /scripts/:id/edit' do -> 'edit' substituída para uma partial
  #  context 'usuário está logado' do
  #    before do
  #      sign_in(user)
  #    end
  #    it 'acessa a página de edição do roteiro com sucesso' do
  #      get edit_script_path(script.id)
  #      expect(response).to have_http_status(:success)
  #      expect(response).to render_template(:edit)
  #    end
  #  end
  #end
  describe 'DELETE /scripts/:id' do
    context 'usuário está logado' do
      before do
        sign_in(user)
      end
      it 'é o proprietário e deleta o roteiro com sucesso' do
        expect {
          delete script_path(script.id)
        }.to change(Script, :count).by(-1)
        expect(response).to redirect_to(root_path)
      end
      it 'não é o proprietário e não deleta o roteiro' do
        other_user = FactoryBot.create(:user)
        other_script = FactoryBot.create(:script, user: other_user)
        Participant.create(user: user, script: other_script)
        expect {
          delete script_path(other_script.id)
        }.to change(Script, :count).by(0)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end

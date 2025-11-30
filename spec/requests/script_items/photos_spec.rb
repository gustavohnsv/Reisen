require 'rails_helper'

RSpec.describe 'ScriptItems::Photos', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, email: 'other@test.com', name: 'Other User') }
  let(:script) { FactoryBot.create(:script, user: user) }
  let(:script_item) { FactoryBot.create(:script_item, script: script, user: user) }
  
  before { sign_in user }
  
  describe 'POST /script_items/:script_item_id/photos' do
    let(:valid_attributes) do
      {
        image: fixture_file_upload('spec/fixtures/files/test_image.jpg', 'image/jpeg'),
        description: 'Linda vista do local'
      }
    end
    
    context 'com parâmetros válidos' do
      it 'cria uma nova foto' do
        expect {
          post script_item_photos_path(script_item), params: { script_item_photo: valid_attributes }
        }.to change(ScriptItemPhoto, :count).by(1)
      end
      
      it 'associa a foto ao usuário correto' do
        post script_item_photos_path(script_item), params: { script_item_photo: valid_attributes }
        expect(ScriptItemPhoto.last.user).to eq(user)
      end
      
      it 'associa a foto ao script_item correto' do
        post script_item_photos_path(script_item), params: { script_item_photo: valid_attributes }
        expect(ScriptItemPhoto.last.script_item).to eq(script_item)
      end
      
      it 'redireciona para o roteiro' do
        post script_item_photos_path(script_item), params: { script_item_photo: valid_attributes }
        expect(response).to redirect_to(script_path(script))
      end
      
      it 'exibe mensagem de sucesso' do
        post script_item_photos_path(script_item), params: { script_item_photo: valid_attributes }
        follow_redirect!
        expect(response.body).to include('Foto adicionada com sucesso')
      end
    end
    
    context 'quando não autenticado' do
      before { sign_out user }
      
      it 'redireciona para login' do
        post script_item_photos_path(script_item), params: { script_item_photo: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
      
      it 'não cria a foto' do
        expect {
          post script_item_photos_path(script_item), params: { script_item_photo: valid_attributes }
        }.not_to change(ScriptItemPhoto, :count)
      end
    end
  end
  
  describe 'DELETE /script_items/:script_item_id/photos/:id' do
    let!(:photo) { FactoryBot.create(:script_item_photo, script_item: script_item, user: user) }
    
    context 'quando é dono da foto' do
      it 'deleta a foto' do
        expect {
          delete script_item_photo_path(script_item, photo)
        }.to change(ScriptItemPhoto, :count).by(-1)
      end
      
      it 'redireciona para o roteiro' do
        delete script_item_photo_path(script_item, photo)
        expect(response).to redirect_to(script_path(script))
      end
      
      it 'exibe mensagem de sucesso' do
        delete script_item_photo_path(script_item, photo)
        follow_redirect!
        expect(response.body).to include('Foto deletada com sucesso')
      end
    end
    
    context 'quando é dono do roteiro mas não da foto' do
      let(:other_photo) { FactoryBot.create(:script_item_photo, script_item: script_item, user: other_user) }
      
      it 'permite deletar a foto' do
        expect {
          delete script_item_photo_path(script_item, other_photo)
        }.to change(ScriptItemPhoto, :count).by(-1)
      end
    end
    
    context 'quando não é dono da foto nem do roteiro' do
      let(:other_script) { FactoryBot.create(:script, user: other_user) }
      let(:other_script_item) { FactoryBot.create(:script_item, script: other_script, user: other_user) }
      let(:other_photo) { FactoryBot.create(:script_item_photo, script_item: other_script_item, user: other_user) }
      
      it 'não deleta a foto' do
        expect {
          delete script_item_photo_path(other_script_item, other_photo)
        }.not_to change(ScriptItemPhoto, :count)
      end
      
      it 'redireciona com mensagem de erro' do
        delete script_item_photo_path(other_script_item, other_photo)
        follow_redirect!
        expect(response.body).to include('Você não tem permissão')
      end
    end
    
    context 'quando não autenticado' do
      before { sign_out user }
      
      it 'redireciona para login' do
        delete script_item_photo_path(script_item, photo)
        expect(response).to redirect_to(new_user_session_path)
      end
      
      it 'não deleta a foto' do
        sign_out user
        expect {
          delete script_item_photo_path(script_item, photo)
        }.not_to change(ScriptItemPhoto, :count)
      end
    end
  end
end
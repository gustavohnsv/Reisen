require 'rails_helper'

RSpec.describe "Scripts::Items", type: :request do

  let!(:user) {FactoryBot.create(:user)}
  let!(:script) {FactoryBot.create(:script, user: user)}
  let!(:item) {FactoryBot.create(:script_item, script: script)}

  describe 'PATCH /scripts/:script_id/script_items/:id' do
    context 'usuário está logado' do
      before do
        sign_in(user)
      end
      it 'atualiza apenas o título do item com sucesso' do
        patch script_script_item_path(script.id, item.id), params: {
          script_item: {title: 'Item atualizado'}
        }
        expect(item.reload.title).to eq('Item atualizado')
      end
      it 'não atualiza o título do item' do
        patch script_script_item_path(script.id, item.id), params: {
          script_item: {title: ''}
        }
        expect(response).to render_template('scripts/show')
      end
      it 'atualiza o título do item de outro roteiro pois é participante' do
        other_user = FactoryBot.create(:user)
        other_script = FactoryBot.create(:script, user: other_user)
        FactoryBot.create(:script_participant, user: user, script: other_script)
        other_item = FactoryBot.create(:script_item, script: other_script)
        patch script_script_item_path(other_script.id, other_item.id), params: {
          script_item: {title: 'Item atualizado'}
        }
        expect(other_item.reload.title).to eq('Item atualizado')
      end
      it 'não atualiza o título do item de outro roteiro pois não é participante' do
        other_user = FactoryBot.create(:user)
        other_script = FactoryBot.create(:script, user: other_user)
        other_item = FactoryBot.create(:script_item, script: other_script)
        patch script_script_item_path(other_script.id, other_item.id), params: {
          script_item: {title: 'Item atualizado'}
        }
        expect(response).to redirect_to(root_path)
      end
    end
    context 'usuário não está logado e possui o token' do
      before do
        @token = script.shareable_token
      end
      it 'não atualiza o título do item' do
        patch script_script_item_url(script.id, item.id, token: @token), params: {
          script_item: {title: ''}
        }
        expect(response).to have_http_status(:unprocessable_content)
        expect(response).to render_template("scripts/show")
      end
    end
    context 'usuário não está logado e não possui o token' do
      before do
        @token = 'fake_token'
      end
      it 'não atualiza o título' do
        patch script_script_item_url(script.id, item.id, token: @token), params: {
          script_item: {title: 'Item atualizado'}
        }
        expect(response).to redirect_to(root_path)
      end
    end
  end
  describe 'POST /scripts/:script_id/script_items' do
    before do
      @valid_params = {
        title: Faker::Lorem.sentence,
        description: Faker::Lorem.paragraph,
        location: Faker::Address.city,
        date_time_start: DateTime.now,
        estimated_cost: 14.99,
        user_id: user.id
      }
      @invalid_params = {
        title: '',
        description: '',
        location: '',
        date_time_start: DateTime.now,
        estimated_cost: 0,
        user_id: user.id
      }
    end
    context 'usuário está logado' do
      before do
        sign_in(user)
      end
      it 'o item do roteiro é criado com sucesso' do
        expect {
          post script_script_items_path(script.id), params: {
            script_item: @valid_params
          }
        }.to change(ScriptItem, :count).by(1)
        expect(response).to redirect_to(script_path(script.id))
      end
      it 'o item do roteiro não é criado com sucesso' do
        expect {
          post script_script_items_path(script.id), params: {
            script_item: @invalid_params
          }
        }.to change(ScriptItem, :count).by(0)
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
    context 'usuário não está logado e possui o token' do
        before do
          @token = script.shareable_token
        end
        it 'o item do roteiro não é criado com sucesso' do
          expect {
            post script_script_items_url(script.id, token: @token), params: {
              script_item: @invalid_params
            }
          }.to change(ScriptItem, :count).by(0)
          expect(response).to have_http_status(:unprocessable_content)
          expect(response).to render_template("scripts/show")
        end
      end
      context 'usuário não está logado e não possui o token' do
        before do
          @token = 'fake_token'
        end
        it 'o item do roteiro não é criado com sucesso' do
          expect {
            post script_script_items_url(script.id, token: @token), params: {
              script_item: @valid_params
            }
          }.to change(ScriptItem, :count).by(0)
          expect(response).to redirect_to(root_path)
        end
    end
  end
  describe 'DELETE /scripts/:script_id/script_items/:id' do
    context 'usuário está logado' do
      before do
        sign_in(user)
      end
      it 'deleta o item com sucesso' do
        expect {
          delete script_script_item_path(script.id, item.id)
        }.to change(ScriptItem, :count).by(-1)
        expect(response).to redirect_to(script_path(script.id))
      end
    end
    context 'usuário não está logado e possui o token' do
      before do
        @token = script.shareable_token
      end
      it 'não deleta o item com sucesso' do
        expect {
          delete script_script_item_url(script.id, item.id, token: @token)
        }.to change(ScriptItem, :count).by(0)
        expect(response).to have_http_status(:unprocessable_content)
        expect(response).to render_template("scripts/show")
      end
    end
    context 'usuário não está logado e não possui o token' do
      before do
        @token = 'fake_token'
      end
      it 'não deleta o item com sucesso' do
        expect {
          delete script_script_item_url(script.id, item.id, token: @token)
        }.to change(ScriptItem, :count).by(0)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end

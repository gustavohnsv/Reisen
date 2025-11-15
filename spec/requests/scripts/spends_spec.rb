require 'rails_helper'

RSpec.describe "Scripts::Spends", type: :request do

  let!(:user) {FactoryBot.create(:user)}
  let!(:script) {FactoryBot.create(:script, user: user)}
  let!(:spend) {FactoryBot.create(:script_spend, user: user, script: script)}

  describe 'POST /scripts/:script_id/script_spends' do
    before do
      @valid_params = {
        amount: 14.99,
        quantity: 1,
        date: Date.today,
        category: 'outros',
        user_id: user.id,
        script_id: script.id
      }
      @invalid_params = {
        amount: nil,
        quantity: nil,
        date: nil,
        category: 'outros',
        user_id: user.id,
        script_id: script.id
      }
    end
    context 'usuário está logado' do
      before do
        sign_in(user)
      end
      it 'o gasto do roteiro é criado com sucesso' do
        expect {
          post script_script_spends_path(script.id), params: {
            script_spend: @valid_params
          }
        }.to change(ScriptSpend, :count).by(1)
        expect(response).to redirect_to(script_path(script.id))
      end
      it 'o gasto do roteiro não é criado com sucesso' do
        expect {
          post script_script_spends_path(script.id), params: {
            script_spend: @invalid_params
          }
        }.to change(ScriptSpend, :count).by(0)
        expect(response).to have_http_status(:unprocessable_content)
      end
      it 'o gasto do roteiro não é criado com sucesso pois não existe roteiro' do
        expect {
          post script_script_spends_path(-1, spend.id), params: {
            script_spend: @valid_params
          }
        }.to change(ScriptSpend, :count).by(0)
        expect(response).to redirect_to(root_path)
      end
    end
    context 'usuário não está logado e possui o token' do
      before do
        @token = script.shareable_token
      end
      it 'o item do roteiro não é criado com sucesso' do
        expect {
          post script_script_spends_url(script.id, token: @token), params: {
            script_spend: @valid_params
          }
        }.to change(ScriptSpend, :count).by(0)
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
          post script_script_spends_url(script.id, token: @token), params: {
            script_spend: @valid_params
          }
        }.to change(ScriptSpend, :count).by(0)
        expect(response).to redirect_to(root_path)
      end
    end
  end
  describe 'DELETE /scripts/:script_id/script_spends/:id' do
    context 'usuário está logado' do
      before do
        sign_in(user)
      end
      it 'deleta o gasto com sucesso' do
        expect {
          delete script_script_spend_path(script.id, spend.id)
        }.to change(ScriptSpend, :count).by(-1)
        expect(response).to redirect_to(script_path(script.id))
      end
      it 'não deleta o item com sucesso pois não é seu' do
        other_user = FactoryBot.create(:user)
        FactoryBot.create(:script_participant, script: script, user: other_user)
        other_spend = FactoryBot.create(:script_spend, user: other_user, script: script)
        expect {
          delete script_script_spend_path(script.id, other_spend.id)
        }.to change(ScriptSpend, :count).by(0)
        expect(response).to redirect_to(script_path(script.id))
      end
    end
    context 'usuário não está logado e possui o token' do
      before do
        @token = script.shareable_token
      end
      it 'não deleta o item com sucesso' do
        expect {
          delete script_script_spend_url(script.id, spend.id, token: @token)
        }.to change(ScriptSpend, :count).by(0)
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
          delete script_script_spend_url(script.id, spend.id, token: @token)
        }.to change(ScriptSpend, :count).by(0)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "Users::Registrations", type: :request do

  let(:valid_attributes) { FactoryBot.attributes_for(:user) }
  let(:invalid_attributes) { FactoryBot.attributes_for(:user, password: '123') }

  describe 'POST /users' do

    context 'no ambiente de teste (lógica de skip_confirmation!)' do
      it 'cria um novo usuário, pula a confirmação e faz o login' do
        expect {
          post user_registration_path, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
        new_user = User.find_by(email: valid_attributes[:email])
        expect(new_user&.confirmed?).to be(true)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'com dados inválidos' do
      it 'não cria um novo usuário e renderiza o formulário novamente' do
        expect {
          post user_registration_path, params: { user: invalid_attributes }
        }.to change(User, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end

    context 'simulando o ambiente de produção' do
      before do
        allow(Rails.env).to receive(:production?).and_return(true)
      end

      it 'cria um novo usuário, mas NÃO pula a confirmação' do
        expect {
          post user_registration_path, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
        new_user = User.find_by(email: valid_attributes[:email])
        expect(new_user&.confirmed?).to be(false)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
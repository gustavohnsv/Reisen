require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    it 'retorna status 200' do
      get :index
      expect(response).to have_http_status(:success)
    end

  end
end

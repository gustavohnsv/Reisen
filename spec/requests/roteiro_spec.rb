require 'rails_helper'

RSpec.describe "Roteiro", type: :request do
  describe "GET /roteiro" do
    it "é acessível sem autenticação" do
      get roteiro_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Roteiro rápido")
    end
  end
end

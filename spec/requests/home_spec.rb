require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe "GET /" do
    it "mostra avisos importantes quando existem" do
      FactoryBot.create(:notice, title: "Reunião de grupo", body: "Reunião amanhã às 10h", visible: true)
      get root_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Avisos Importantes')
      expect(response.body).to include('Reunião de grupo')
    end

    it "não mostra avisos invisíveis" do
      FactoryBot.create(:notice, title: "Segredo", visible: false)
      get root_path
      expect(response.body).not_to include('Segredo')
    end
  end
end
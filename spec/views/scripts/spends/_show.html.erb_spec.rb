require 'rails_helper'

RSpec.describe "scripts/spends/_show.html.erb", type: :view do

  include ActionView::Helpers::NumberHelper

  let(:user) { FactoryBot.create(:user) }
  let(:script) { FactoryBot.create(:script, user: user) }
  let(:target_date) { Date.today }

  context "quando filtrando por data" do
    let!(:spend_on_date) do
      FactoryBot.create(:script_spend,
             script: script,
             user: user,
             date: target_date,
             category: 'alimentacao')
    end

    let!(:spend_off_date) do
      FactoryBot.create(:script_spend,
             script: script,
             user: user,
             date: Date.yesterday,
             category: 'transporte')
    end

    before(:each) do
      render partial: "scripts/spends/show",
             locals: {
               script: script,
               items: [],
               date: target_date,
               day_spends: [spend_on_date]
             }
    end

    it "mostra o gasto da data correta" do
      expect(rendered).to include('Alimentação')
    end

    it "NÃO mostra gastos de outras datas" do
      expect(rendered).not_to include('Transporte')
    end
  end

  context "quando há orçamento (itens)" do
    let(:item_com_custo) do
      create(:script_item,
             script: script,
             date_time_start: target_date.to_time,
             estimated_cost: 200)
    end
    let!(:gasto_do_dia) do
      create(:script_spend,
             script: script,
             date: target_date,
             amount: 50,
             user: user)
    end

    before(:each) do
      render partial: "scripts/spends/show",
             locals: {
               script: script,
               items: [item_com_custo],
               date: target_date,
               day_spends: [gasto_do_dia]
             }
    end

    it 'mostra a barra de progresso do orçamento corretamente' do
      expect(rendered).to include("#{number_to_currency(50)} / #{number_to_currency(200)}")

      expect(rendered).to include('width: 25.0%;')
      expect(rendered).to include('bg-success')
    end
  end

  context "no modal de gerenciamento" do
    let(:user_dono_do_gasto) { create(:user) }
    let(:outro_usuario) { create(:user) }

    let!(:gasto) do
      create(:script_spend,
             script: script,
             date: target_date,
             user: user_dono_do_gasto)
    end

    it 'mostra o botão de excluir se o gasto pertence ao current_user' do
      allow(view).to receive(:current_user).and_return(user_dono_do_gasto)

      render partial: "scripts/spends/show", locals: { script: script, items: [], date: target_date, day_spends: [gasto] }

      expect(rendered).to include('button_to')
      expect(rendered).to include(script_script_spend_path(script.id, gasto.id))

      expect(rendered).to include("Registrado por: Você (#{user_dono_do_gasto.name})")
    end

    it 'NÃO mostra o botão de excluir se o gasto for de outro usuário' do
      allow(view).to receive(:current_user).and_return(outro_usuario)

      render partial: "scripts/spends/show", locals: { script: script, items: [], date: target_date, day_spends: [gasto] }

      expect(rendered).not_to include('button_to')
      expect(rendered).to include("Registrado por: #{user_dono_do_gasto.name}")
      expect(rendered).not_to include("Registrado por: Você")
    end
  end
end
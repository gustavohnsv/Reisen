require 'rails_helper'

RSpec.describe "script/spends/_new.html.erb", type: :view do

  let!(:user) {FactoryBot.create(:user)}
  let!(:script) {FactoryBot.create(:script, user: user)}
  let!(:spend) {FactoryBot.create(:script_spend, script: script, user: user)}

  before(:each) do
    assign(:user, user)
    render :partial => "scripts/spends/new", :locals => {script: script, spend: spend}
  end
  it 'deve conter um campo para inserir o valor' do
    expect(rendered).to have_field('new-spend-amount')
  end
  it 'deve conter um campo para inserir a quantidade' do
    expect(rendered).to have_field('new-spend-quantity')
  end
  it 'deve conter um campo para inserir a data' do
    expect(rendered).to have_field('new-spend-date')
  end
  it 'deve conter um campo para inserir a categoria' do
    expect(rendered).to have_field('new-spend-category')
  end
  it 'deve conter um botão para registrar o gasto' do
    expect(rendered).to have_button('Adicionar Gasto')
  end
end

require 'rails_helper'

RSpec.describe "scripts/items/_new.html.erb", type: :view do

  let!(:user) {FactoryBot.create(:user)}
  let!(:script) {FactoryBot.create(:script, user: user)}
  let!(:item) {FactoryBot.build(:script_item, script: script)}

  before(:each) do
    assign(:user, user)
    render :partial => "scripts/items/new", :locals => {script: script, item: item}
  end

  it 'deve conter um campo para inserir o título' do
    expect(rendered).to have_field('new-item-title')
  end
  it 'deve conter um campo para inserir a descrição' do
    expect(rendered).to have_field('new-item-description')
  end
  it 'deve conter um campo para inserir a localização' do
    expect(rendered).to have_field('new-item-location')
  end
  it 'deve conter um campo para inserir a data e hora de início' do
    expect(rendered).to have_field('new-item-date-time-start')
  end
  it 'deve conter um campo para inserir o custo estimado' do
    expect(rendered).to have_field('new-item-estimated-cost')
  end
  it 'deve conter um botão para criar o item' do
    expect(rendered).to have_button('add')
  end
end
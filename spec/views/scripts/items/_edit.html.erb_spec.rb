require 'rails_helper'

RSpec.describe "scripts/items/_edit.html.erb", type: :view do

  let!(:user) {FactoryBot.create(:user)}
  let!(:script) {FactoryBot.create(:script, user: user)}
  let!(:item) {FactoryBot.create(:script_item, script: script)}

  before(:each) do
    assign(:user, user)
    render :partial => "scripts/items/edit", :locals => {script: script, item: item}
  end

  it 'deve conter um campo com o título do item' do
    field = "edit-item-title_#{item.id}"
    expect(rendered).to have_field(field)
  end
  it 'deve conter um campo com a descrição do item' do
    field = "edit-item-description_#{item.id}"
    expect(rendered).to have_field(field)
  end
  it 'deve conter um campo com a localização do item' do
    field = "edit-item-location_#{item.id}"
    expect(rendered).to have_field(field)
  end
  it 'deve conter um campo com a data e hora de ínicio do item' do
    field = "edit-item-date-time-start_#{item.id}"
    expect(rendered).to have_field(field)
  end
  it 'deve conter um campo com o custo estimado do item' do
    field = "edit-item-estimated-cost_#{item.id}"
    expect(rendered).to have_field(field)
  end
  it 'deve conter um botão para deletar o item' do
    expect(rendered).to have_button('close')
  end
end
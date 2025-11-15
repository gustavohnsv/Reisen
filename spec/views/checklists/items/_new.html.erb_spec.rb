require 'rails_helper'

RSpec.describe "checklists/items/_new.html.erb", type: :view do

  let!(:user) {FactoryBot.create(:user)}
  let!(:checklist) {FactoryBot.create(:checklist, user: user)}
  let!(:item) {FactoryBot.create(:checklist_item, checklist: checklist)}

  before(:each) do
    assign(:user, user)
    render :partial => "checklists/items/new", :locals => {checklist: checklist, item: item}
  end

  it 'deve conter um campo de texto para a descriçao' do
    expect(rendered).to have_field('new-item-description')
  end
  it 'deve conter um botao para criar o item' do
    expect(rendered).to have_button('add')
  end
end
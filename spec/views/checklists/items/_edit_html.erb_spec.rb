require 'rails_helper'

RSpec.describe "checklists/items/_edit.html.erb_spec.rb", type: :view do

  let!(:user) {FactoryBot.create(:user)}
  let!(:checklist) {FactoryBot.create(:checklist, user: user)}
  let!(:item) {FactoryBot.create(:checklist_item, checklist: checklist)}

  before(:each) do
    assign(:user, user)
    render :partial => "checklists/items/edit", :locals => {checklist: checklist, item: item}
  end

  it 'deve conter um campo de texto para editar a descriçao' do
    field = "edit-item-description_#{item.id}"
    expect(rendered).to have_field(field)
  end
  it 'deve conter um botao para atualizar o item' do
    expect(rendered).to have_button("check")
  end
  it 'deve conter um botao para deletar o item' do
    expect(rendered).to have_button("close")
  end
  it 'deve conter uma caixa de selecao' do
    field = "edit-item-check_#{item.id}"
    expect(rendered).to have_unchecked_field(field)
  end
end
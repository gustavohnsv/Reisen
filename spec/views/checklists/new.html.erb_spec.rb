require 'rails_helper'

RSpec.describe "checklists/new.html.erb", type: :view do

  let!(:user) {FactoryBot.create(:user)}
  let!(:checklist) {FactoryBot.create(:checklist, user: user)}

  before(:each) do
    assign(:user, user)
    assign(:checklist, checklist)
    render
  end

  it 'deve conter um campo de texto para o título' do
    expect(rendered).to have_field('Title')
  end
  it 'deve conter um botão para criar a checklist' do
    expect(rendered).to have_button("Criar checklist")
  end
end

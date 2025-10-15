require 'rails_helper'

RSpec.describe "scripts/new.html.erb", type: :view do

  let!(:user) {FactoryBot.create(:user)}
  let!(:script) {FactoryBot.create(:script, user: user)}

  before(:each) do
    assign(:user, user)
    assign(:script, script)
    render
  end

  it 'deve conter um campo de texto para o título' do
    expect(rendered).to have_field('Title')
  end
  it 'deve conter um botão para criar o roteiro' do
    expect(rendered).to have_button("Criar roteiro")
  end
end

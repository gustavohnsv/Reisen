require 'rails_helper'

RSpec.describe "checklists/show.html.erb", type: :view do

  let!(:user) {FactoryBot.create(:user)}
  let!(:checklist) {FactoryBot.create(:checklist, user: user)}

  before(:each) do
    assign(:user, user)
    assign(:checklist, checklist)
    render
  end

  it 'deve conter o nome da checklist' do
    expect(rendered).to have_content(checklist.title)
  end
  it 'deve conter o proprietário da checklist' do
    expect(rendered).to have_content(user.name)
  end
end

require 'rails_helper'

RSpec.describe "checklists/show.html.erb", type: :view do

  let!(:user) {FactoryBot.create(:user)}
  let!(:checklist) {FactoryBot.create(:checklist, user: user)}
  let!(:item) {FactoryBot.create(:checklist_item, checklist: checklist)}

  before(:each) do
    assign(:user, user)
    assign(:checklist, checklist)
    assign(:item, item)
    render
  end

  it 'deve conter o nome da checklist' do
    expect(rendered).to have_field("edit-title", with: checklist.title)
    #expect(rendered).to have_content(checklist.title)
  end
    #it 'deve conter o proprietário da checklist' do
    #expect(rendered).to have_content(user.name)
    #end
end

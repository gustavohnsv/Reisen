require 'rails_helper'

RSpec.describe Notice, type: :model do
  it 'valida presença de título e body' do
    notice = Notice.new(title: nil, body: nil)
    expect(notice).not_to be_valid
    expect(notice.errors[:title]).to be_present
    expect(notice.errors[:body]).to be_present
  end

  it 'scope visible retorna apenas visíveis' do
    visible = FactoryBot.create(:notice, visible: true)
    hidden  = FactoryBot.create(:notice, visible: false)
    expect(Notice.visible).to include(visible)
    expect(Notice.visible).not_to include(hidden)
  end
end
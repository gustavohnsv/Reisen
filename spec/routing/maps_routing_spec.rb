require 'rails_helper'

RSpec.describe 'Maps routing', type: :routing do
  it 'roteia GET /maps/search para maps#search' do
    expect(get: '/maps/search').to route_to(controller: 'maps', action: 'search')
  end

  it 'roteia POST /maps/search para maps#submit' do
    expect(post: '/maps/search').to route_to(controller: 'maps', action: 'submit')
  end
end


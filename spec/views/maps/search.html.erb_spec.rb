require 'rails_helper'

RSpec.describe 'maps/search.html.erb', type: :view do
  it 'exibe formulário com classes Bootstrap e action correta' do
    render

    expect(rendered).to match(/<form[^>]*action=\"#{Regexp.escape(maps_search_submit_path)}\"/)
    expect(rendered).to include('class="form-control"')
    expect(rendered).to include('class="btn btn-primary"')
    expect(rendered).to include('name="query"')
    expect(rendered).to include('id="maps-query"')
  end
end


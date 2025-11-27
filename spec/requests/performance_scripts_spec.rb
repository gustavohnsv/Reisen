require 'rails_helper'

RSpec.describe "Scripts Performance", type: :request do
  let(:user) { create(:user) }
  let(:script) { create(:script, user: user) }

  before do
    sign_in user, scope: :user
    # Create data for 3 days
    3.times do |i|
      date = Date.today + i.days
      create(:script_item, script: script, date_time_start: date.to_time, date_time_end: date.to_time + 1.hour)
      create_list(:script_spend, 5, script: script, date: date, user: user)
    end
  end

  it "does not have N+1 queries when rendering the show page" do
    # Warm up
    get script_path(script)
    
    # The exact number depends on other things, but it shouldn't be proportional to days.
    
    # Using a block to count queries
    count = count_queries { get script_path(script) }
    
    # Let's add another day with spends
    create_list(:script_spend, 5, script: script, date: Date.today + 4.days, user: user)
    
    count_with_more_data = count_queries { get script_path(script) }
    
    # If N+1 exists, count_with_more_data will be > count
    expect(count_with_more_data).to be <= count
  end

  def count_queries
    count = 0
    subscriber = ActiveSupport::Notifications.subscribe("sql.active_record") do |name, start, finish, id, payload|
      count += 1 unless payload[:name] == "SCHEMA" # Ignore schema queries
    end
    yield
    ActiveSupport::Notifications.unsubscribe(subscriber)
    count
  end
end

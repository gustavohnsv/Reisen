FactoryBot.define do
  factory :script_item do
    sequence(:title) { |n| "Título #{n}" }
    description { Faker::Lorem.sentence }
    location { Faker::Address.city }
    date_time_start { Date.current }
    estimated_cost { 14.99 }
    user { nil }
    script { nil }
  end
end

FactoryBot.define do
  factory :destination do
    name { Faker::Address.city }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
  end
end
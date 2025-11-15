FactoryBot.define do
  factory :hotel do
    name { "Hotel #{Faker::Company.name}" }
    address { Faker::Address.full_address }
  end
end
FactoryBot.define do
  factory :script do
    sequence(:title) { |n| "Roteiro #{n}" }
    user { nil }
  end
end

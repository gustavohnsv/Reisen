FactoryBot.define do
  factory :script_spend do
    amount { "9.99" }
    quantity { 1 }
    date { Date.current }
    category { "outros" }
    user { nil }
    script { nil }
  end
end

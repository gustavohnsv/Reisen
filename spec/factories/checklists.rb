FactoryBot.define do
  factory :checklist do
    sequence(:title) { |n| "Checklist #{n}" }
    user { nil }
  end
end

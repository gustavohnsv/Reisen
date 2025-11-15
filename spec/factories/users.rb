FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "John Doe #{n}" }
    sequence(:email) { |n| "johndoe#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.current }
  end
end

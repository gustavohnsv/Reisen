FactoryBot.define do
  factory :review do
    association :user
    association :reviewable, factory: :destination
    rating { rand(1..5) }
    comment { Faker::Lorem.paragraph }
    title { Faker::Lorem.sentence(word_count: 3) }

    trait :for_destination do
      association :reviewable, factory: :destination
    end

    trait :for_hotel do
      association :reviewable, factory: :hotel
    end

    trait :for_tour do
      association :reviewable, factory: :tour
    end

    trait :high_rating do
      rating { 5 }
    end

    trait :low_rating do
      rating { 1 }
    end
  end
end
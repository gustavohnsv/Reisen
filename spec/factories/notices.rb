# spec/factories/notices.rb
FactoryBot.define do
  factory :notice do
    sequence(:title) { |n| "Aviso importante #{n}" }
    body { "Texto do aviso: lembretes importantes para o grupo." }
    visible { true }

    # se você tiver uma factory :user e quiser associar:
    association :user, factory: :user
    trait :hidden do
      visible { false }
    end
  end
end
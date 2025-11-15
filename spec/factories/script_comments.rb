FactoryBot.define do
  factory :script_comment do
    content { "MyText" }
    user { nil }
    script { nil }
  end
end

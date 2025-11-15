FactoryBot.define do
  factory :script_participant do
    permission { 1 }
    user { nil }
    script { nil }
  end
end

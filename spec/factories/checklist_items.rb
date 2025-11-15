FactoryBot.define do
  factory :checklist_item do
    sequence(:description) { |n| "Item #{n}" }
    checklist { nil }
    check { false }
  end
end

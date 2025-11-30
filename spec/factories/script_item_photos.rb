FactoryBot.define do
  factory :script_item_photo do
    association :script_item
    association :user
    description { "Esta é uma foto de teste" }
    
    after(:build) do |photo|
      photo.image.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg')),
        filename: 'test_image.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end
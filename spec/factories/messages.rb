FactoryBot.define do
  factory :message do
    text {Faker::Lorem.sentence}
    image {File.open("#{Rails.root}/public/images/test_image.png")}
    user_id { 1 }
    group_id { 1 }
  end
end

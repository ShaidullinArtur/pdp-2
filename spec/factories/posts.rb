FactoryGirl.define do
  factory :post do
    title { Faker::Name.title }
    text { Faker::Lorem.paragraph(20) }
    rating { Faker::Number.between(1, 5) }
  end
end

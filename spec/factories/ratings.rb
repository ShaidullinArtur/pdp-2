FactoryGirl.define do
  factory :rating do
    value { Faker::Number.between(1, 5) }
  end
end

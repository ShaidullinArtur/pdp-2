FactoryGirl.define do
  factory :rating do
    value { Faker::Number.between(1, 5) }

    trait :with_user do
      after(:build) do |rating, _evaluator|
        rating.user = create(:user)
      end
    end
  end
end

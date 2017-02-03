FactoryGirl.define do
  factory :user do
    email
    full_name { Faker::Name.name }
    password "123123123"
    password_confirmation { password }
    confirmed_at 1.hour.ago
    average_rating { Faker::Number.between(1, 5) }

    trait :not_confirmed do
      confirmed_at nil

      after(:create) do |user|
        user.update(confirmation_sent_at: 3.days.ago)
      end
    end
  end
end

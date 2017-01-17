FactoryGirl.define do
  factory :admin_user do
    email
    full_name { Faker::Name.name }
    password "123123123"
    password_confirmation { password }
    confirmed_at 1.hour.ago

    trait :not_confirmed do
      confirmed_at nil

      after(:create) do |admin_user|
        admin_user.update(confirmation_sent_at: 3.days.ago)
      end
    end
  end
end

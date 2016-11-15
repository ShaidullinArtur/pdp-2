FactoryGirl.define do
  factory :company do
    title { Faker::Name.title }
    subdomain { Faker::Internet.domain_name }

    trait :with_owner do
      after(:build) do |company, evaluator|
        company.owner = create(:user, subdomain: company.subdomain)
      end
    end
  end
end

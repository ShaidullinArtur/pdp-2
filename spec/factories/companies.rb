FactoryGirl.define do
  factory :company do
    title { Faker::Name.title }
    subdomain { [Faker::Internet.domain_name, Time.current.to_i.to_s].join(".") }

    trait :with_owner do
      after(:build) do |company, evaluator|
        company.owner = create(:user, subdomain: company.subdomain)
      end
    end
  end
end

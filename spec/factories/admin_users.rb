FactoryGirl.define do
  factory :admin_user do
    email
    password "123123123"
    password_confirmation { password }
  end
end

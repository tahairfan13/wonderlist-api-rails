FactoryGirl.define do
  factory :auth do
    association :user
    password "password"
    password_confirmation "password"
  end
end

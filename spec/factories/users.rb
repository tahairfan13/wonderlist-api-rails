FactoryGirl.define do
  factory :user do
    name "Taha test"
    email "taha@123"
    username "taha123"
    #sequence(:username) { |n| "taha #{n}" }
  end
end

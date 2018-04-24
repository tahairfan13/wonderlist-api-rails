FactoryGirl.define do
  factory :task do
    name "task"
    association :list
  end
end

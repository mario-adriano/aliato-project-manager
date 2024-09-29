FactoryBot.define do
  factory :project do
    sequence(:code) { |n| "PRJ#{n}" }
    description { "Sample project description" }
    association :user
    association :client
    association :phase
  end
end

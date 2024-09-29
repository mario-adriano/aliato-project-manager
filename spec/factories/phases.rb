FactoryBot.define do
  factory :phase do
    name { "Phase #{rand(1000)}" }
    position { rand(1..10) }
    description { "Sample description" }
    is_end { false }
  end
end

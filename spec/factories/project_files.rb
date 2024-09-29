FactoryBot.define do
  factory :project_file do
    sequence(:file_name) { |n| "file#{n}.txt" }
    file_data { "Sample file content" }
    price { 100.00 }
    association :project
  end
end

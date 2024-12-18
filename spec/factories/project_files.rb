# == Schema Information
#
# Table name: project_files
#
#  id         :bigint           not null, primary key
#  file_data  :binary
#  file_name  :string
#  price      :decimal(8, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :bigint           not null
#
# Indexes
#
#  index_project_files_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
FactoryBot.define do
  factory :project_file do
    sequence(:file_name) { |n| "file#{n}.txt" }
    file_data { "Sample file content" }
    price { 100.00 }
    association :project
  end
end

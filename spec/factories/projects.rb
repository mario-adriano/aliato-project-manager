# == Schema Information
#
# Table name: projects
#
#  id          :bigint           not null, primary key
#  code        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  client_id   :bigint           not null
#  phase_id    :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_projects_on_client_id  (client_id)
#  index_projects_on_code       (code) UNIQUE
#  index_projects_on_phase_id   (phase_id)
#  index_projects_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#  fk_rails_...  (phase_id => phases.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :project do
    sequence(:code) { |n| "PRJ#{n}" }
    description { "Sample project description" }
    association :user
    association :client
    association :phase
  end
end

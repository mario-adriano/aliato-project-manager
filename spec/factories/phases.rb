# == Schema Information
#
# Table name: phases
#
#  id             :bigint           not null, primary key
#  deleted_at     :datetime
#  description    :text
#  is_end         :boolean
#  name           :string
#  position       :integer
#  projects_count :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_phases_on_deleted_at  (deleted_at)
#  index_phases_on_position    (position)
#
FactoryBot.define do
  factory :phase do
    name { "Phase #{rand(1000)}" }
    position { rand(1..10) }
    description { "Sample description" }
    is_end { false }
  end
end

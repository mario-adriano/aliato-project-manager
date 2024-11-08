# == Schema Information
#
# Table name: daily_reports
#
#  id                  :bigint           not null, primary key
#  activities          :text
#  afternoon_condition :string
#  completed_at        :datetime
#  date                :date
#  deleted_at          :datetime
#  equipment           :text
#  labor               :text
#  morning_condition   :string
#  observations        :text
#  occurrences         :text
#  token               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  project_id          :bigint           not null
#
# Indexes
#
#  index_daily_reports_on_deleted_at  (deleted_at)
#  index_daily_reports_on_project_id  (project_id)
#  index_daily_reports_on_token       (token)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
require 'rails_helper'

RSpec.describe DailyReport, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

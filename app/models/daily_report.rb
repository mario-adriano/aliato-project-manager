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
class DailyReport < ApplicationRecord
  acts_as_paranoid

  belongs_to :project

  validates :date, presence: true
  # validates :morning_condition, :afternoon_condition, presence: true

  before_create :generate_token

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
end

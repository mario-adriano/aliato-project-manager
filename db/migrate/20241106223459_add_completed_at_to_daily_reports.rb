class AddCompletedAtToDailyReports < ActiveRecord::Migration[7.2]
  def change
    add_column :daily_reports, :completed_at, :datetime
  end
end

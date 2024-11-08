class AddFieldsToDailyReports < ActiveRecord::Migration[7.2]
  def change
    add_column :daily_reports, :labor, :text
    add_column :daily_reports, :equipment, :text
    add_column :daily_reports, :activities, :text
    add_column :daily_reports, :occurrences, :text
  end
end

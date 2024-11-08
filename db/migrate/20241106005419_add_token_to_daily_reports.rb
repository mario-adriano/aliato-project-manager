class AddTokenToDailyReports < ActiveRecord::Migration[7.2]
  def change
    add_column :daily_reports, :token, :string
    add_index :daily_reports, :token
  end
end

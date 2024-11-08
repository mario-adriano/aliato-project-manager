class AddDeletedAtToDailyReport < ActiveRecord::Migration[7.2]
  def change
    add_column :daily_reports, :deleted_at, :datetime
    add_index :daily_reports, :deleted_at
  end
end

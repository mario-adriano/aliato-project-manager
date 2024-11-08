class CreateDailyReports < ActiveRecord::Migration[7.2]
  def change
    create_table :daily_reports do |t|
      t.date :date
      t.string :morning_condition
      t.string :afternoon_condition
      t.text :observations
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end

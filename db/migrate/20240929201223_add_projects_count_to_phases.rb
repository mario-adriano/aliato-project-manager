class AddProjectsCountToPhases < ActiveRecord::Migration[7.1]
  def change
    add_column :phases, :projects_count, :integer, default: 0, null: false
  end
end

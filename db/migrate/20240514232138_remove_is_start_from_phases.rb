class RemoveIsStartFromPhases < ActiveRecord::Migration[7.1]
  def change
    remove_column :phases, :is_start, :boolean
  end
end

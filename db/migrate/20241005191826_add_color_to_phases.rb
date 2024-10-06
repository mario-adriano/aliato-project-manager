class AddColorToPhases < ActiveRecord::Migration[7.1]
  def change
    add_column :phases, :color, :string
  end
end

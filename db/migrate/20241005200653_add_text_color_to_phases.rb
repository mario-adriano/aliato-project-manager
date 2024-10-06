class AddTextColorToPhases < ActiveRecord::Migration[7.1]
  def change
    add_column :phases, :text_color, :string
  end
end

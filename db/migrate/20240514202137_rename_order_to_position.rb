class RenameOrderToPosition < ActiveRecord::Migration[7.1]
  def change
    rename_column :phases, :order, :position
  end
end

class AddOrderToPhases < ActiveRecord::Migration[7.1]
  def change
    add_column :phases, :order, :integer
    add_index :phases, :order, unique: true
  end
end

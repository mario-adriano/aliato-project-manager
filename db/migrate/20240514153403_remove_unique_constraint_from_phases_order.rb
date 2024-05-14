class RemoveUniqueConstraintFromPhasesOrder < ActiveRecord::Migration[7.1]
  def change
    remove_index :phases, :order, unique: true
    add_index :phases, :order
  end
end

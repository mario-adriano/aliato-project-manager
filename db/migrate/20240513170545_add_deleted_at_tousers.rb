class AddDeletedAtTousers < ActiveRecord::Migration[7.1]
  def change
    add_column :Users, :deleted_at, :datetime
    add_index :Users, :deleted_at
  end
end

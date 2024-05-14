class CreatePhases < ActiveRecord::Migration[7.1]
  def change
    create_table :phases do |t|
      t.string :name
      t.text :description
      t.boolean :is_start
      t.boolean :is_end

      t.timestamps
    end
  end
end

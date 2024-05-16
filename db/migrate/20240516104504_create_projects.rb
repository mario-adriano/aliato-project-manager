class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.references :user, null: false, foreign_key: true
      t.references :phase, null: false, foreign_key: true
      t.text :description
      t.string :code

      t.timestamps
    end
    add_index :projects, :code, unique: true
  end
end

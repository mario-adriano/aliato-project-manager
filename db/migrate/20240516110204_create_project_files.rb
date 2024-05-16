class CreateProjectFiles < ActiveRecord::Migration[7.1]
  def change
    create_table :project_files do |t|
      t.references :project, null: false, foreign_key: true
      t.binary :file_data
      t.string :file_name
      t.decimal :price, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end

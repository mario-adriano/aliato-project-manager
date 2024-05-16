class AddClientToProjects < ActiveRecord::Migration[7.1]
  def change
    add_reference :projects, :client, null: false, foreign_key: true
  end
end

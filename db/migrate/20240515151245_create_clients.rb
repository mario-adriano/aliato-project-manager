class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.string :type
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :complement
      t.string :document_number
      t.string :rg
      t.string :company_name

      t.timestamps
    end
  end
end

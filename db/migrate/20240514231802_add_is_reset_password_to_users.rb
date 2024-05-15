class AddIsResetPasswordToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :is_reset_password, :boolean, default: false
  end
end

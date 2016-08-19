class MoveAdminusersToUsers < ActiveRecord::Migration[5.0]
  def change
    rename_table :admin_users, :users
  end
end

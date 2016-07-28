class AddAdminUserToRats < ActiveRecord::Migration[5.0]
  def change
    add_reference :rats, :admin_user
  end
end

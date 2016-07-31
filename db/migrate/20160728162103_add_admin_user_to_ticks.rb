class AddAdminUserToTicks < ActiveRecord::Migration[5.0]
  def change
    add_reference :ticks, :admin_user
  end
end

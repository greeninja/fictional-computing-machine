class AddBolleanColumnsToNotifications < ActiveRecord::Migration[5.0]
  def change
    # Add :user, :supervisor, :team_leader, :junior_admin, :admin to notifications
    add_column :notifications, :user, :boolean
    add_column :notifications, :supervisor, :boolean
    add_column :notifications, :team_leader, :boolean
    add_column :notifications, :junior_admin, :boolean
    add_column :notifications, :admin, :boolean
    remove_column :notifications, :group, :string
  end
end

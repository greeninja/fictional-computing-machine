class UserToAgentidColumns < ActiveRecord::Migration[5.0]
  def change
    rename_column :rats, :user_id, :agent_id
    rename_column :ticks, :user_id, :agent_id
  end
end

class UserToAgentRename < ActiveRecord::Migration[5.0]
  def change
    rename_table :users, :agents
  end
end

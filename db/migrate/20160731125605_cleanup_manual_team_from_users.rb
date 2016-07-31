class CleanupManualTeamFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, "manual_team", :string
  end
end

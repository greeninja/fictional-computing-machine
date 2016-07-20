class ReanmeUserTeamColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :team, :manual_team
  end
end

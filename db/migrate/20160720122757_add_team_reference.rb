class AddTeamReference < ActiveRecord::Migration[5.0]
  def change
    add_column "users", "team_id", :integer
  end
end

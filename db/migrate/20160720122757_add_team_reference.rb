class AddTeamReference < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :team
  end
end

class TeamsUsersJoin < ActiveRecord::Migration[5.0]
  def change
    create_table :user_teams do |t|
      t.references :user
      t.references :team
      t.string :summary
      t.timestamps null: false
    end
    add_index :user_teams, ["user_id", "team_id"]
  end
end

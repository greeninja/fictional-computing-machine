class ChangeTeamDescriptionToText < ActiveRecord::Migration[5.0]
  def change
    change_column("teams", "description", :text)
  end
end

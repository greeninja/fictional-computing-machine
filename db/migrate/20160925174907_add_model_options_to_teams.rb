class AddModelOptionsToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :rats_enabled, :boolean, :default => true
    add_column :teams, :ticks_enabled, :boolean, :default => true
    add_column :teams, :qa_enabled, :boolean, :default => true
  end
end

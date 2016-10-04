class RenameColumnsToCrosses < ActiveRecord::Migration[5.0]
  def change
    rename_column :crosses, :rat_type_id, :cross_type_id
    rename_column :teams, :rats_enabled, :cross_enabled
  end
end

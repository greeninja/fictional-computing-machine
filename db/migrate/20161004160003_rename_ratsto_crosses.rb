class RenameRatstoCrosses < ActiveRecord::Migration[5.0]
  def change
    rename_table :rats, :crosses
    rename_table :rat_types, :cross_types
  end
end

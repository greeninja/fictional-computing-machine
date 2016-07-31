class AddColumnsToSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :settings, :name, :string
    add_column :settings, :description, :text
    add_column :settings, :enabled, :boolean
  end
end

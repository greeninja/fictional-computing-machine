class CustomidToBigInt < ActiveRecord::Migration[5.0]
  def up
    change_column("users", "customid", :integer, :limit => 8, :default => :null, :null => true)
  end
  def down
    change_column("users", "customid", :string)
  end
end

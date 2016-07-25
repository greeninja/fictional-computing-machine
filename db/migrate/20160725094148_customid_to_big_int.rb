class CustomidToBigInt < ActiveRecord::Migration[5.0]
  def change
    change_column("users", "customid", :integer, :limit => 8, :default => 0)
  end
end

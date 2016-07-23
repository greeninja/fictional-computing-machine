class AddCustomIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column "users", "customid", :string
  end
end

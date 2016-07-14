class CreateAdminUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_users do |t|
      
      t.string :first_name, :limit => 25
      t.string :last_name, :limit => 50
      t.string :username, :limit => 25
      t.string :email
      t.string :password_digest
      t.timestamps
    end
  end
end

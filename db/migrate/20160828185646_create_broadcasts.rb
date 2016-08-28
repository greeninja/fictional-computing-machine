class CreateBroadcasts < ActiveRecord::Migration[5.0]
  def change
    create_table :broadcasts do |t|
      t.string :controller
      t.string :item
      t.integer :user_id
      t.boolean :read, default: false
      t.timestamps
    end
  end
end

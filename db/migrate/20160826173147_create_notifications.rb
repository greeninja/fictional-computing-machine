class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.string :controller
      t.integer :item
      t.integer :creator
      t.integer :recipient
      t.string :group
      t.text :message
      t.boolean :read
      t.timestamps
    end
  end
end

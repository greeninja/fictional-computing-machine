class CreateTicks < ActiveRecord::Migration[5.0]
  def change
    create_table :ticks do |t|
      t.integer "user_id"
      t.boolean "ab"
      t.boolean "late"
      t.boolean "dynamic"
      t.boolean "initiative"
      t.boolean "void"
      t.string "notes" 
      t.timestamps
    end
  end
end

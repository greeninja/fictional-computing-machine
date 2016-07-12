class CreateRats < ActiveRecord::Migration[5.0]
  def change
    create_table :rats do |t|
      t.integer "user_id"
      t.boolean :longbreak
      t.boolean :latebreak
      t.boolean :offtask
      t.string :other

      t.timestamps
    end
  end
end

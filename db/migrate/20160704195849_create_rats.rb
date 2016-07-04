class CreateRats < ActiveRecord::Migration[5.0]
  def change
    create_table :rats do |t|
      t.references :users, foreign_key: true
      t.boolean :longbreak
      t.boolean :latebreak
      t.boolean :offtask
      t.string :other

      t.timestamps
    end
  end
end

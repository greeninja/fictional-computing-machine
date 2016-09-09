class CreateQas < ActiveRecord::Migration[5.0]
  def change
    create_table :qas do |t|
      t.integer :qa_setting_id
      t.integer :ticket_id
      t.integer :score
      t.integer :out_of

      t.timestamps
    end
  end
end

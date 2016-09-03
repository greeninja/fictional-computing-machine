class CreateQaSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :qa_settings do |t|
      t.integer :setting_id
      t.integer :team_id
      t.string :qa
      t.text :description
      t.integer :out_of
      t.timestamps
    end
  end
end

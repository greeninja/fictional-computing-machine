class CreateQaGeneralSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :qa_general_settings do |t|
      t.string :name
      t.string :value
      t.integer :setting_id
      t.integer :team_id
      t.boolean :disabled
      t.timestamps
    end
  end
end

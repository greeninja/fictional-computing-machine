class CreateRatTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :rat_types do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end

class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.string :ticket_reference
      t.date :date
      t.integer :agent_id
      t.integer :qa_id
      t.integer :met_id
      t.integer :score
      t.text :notes
      t.timestamps
    end
  end
end

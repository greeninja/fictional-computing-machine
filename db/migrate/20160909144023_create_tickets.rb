class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.string :ticket_number
      t.date :date
      t.integer :agent_id
      t.integer :qa_id
      t.integer :met_id
      t.text :notes
      t.timestamps
    end
  end
end

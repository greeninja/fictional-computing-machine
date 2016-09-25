class AddFeedbackToTickets < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :feedback, :boolean, default: false
  end
end

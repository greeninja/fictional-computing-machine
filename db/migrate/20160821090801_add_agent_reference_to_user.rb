class AddAgentReferenceToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :agent
  end
end

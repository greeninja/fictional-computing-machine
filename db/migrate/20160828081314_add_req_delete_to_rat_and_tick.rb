class AddReqDeleteToRatAndTick < ActiveRecord::Migration[5.0]
  def change
    add_column :rats, :req_delete, :boolean
    add_column :ticks, :req_delete, :boolean
  end
end

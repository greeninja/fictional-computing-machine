class AddReqReasonToRatAndTicks < ActiveRecord::Migration[5.0]
  def change
    add_column :rats, :req_reason, :text
    add_column :ticks, :req_reason, :text
  end
end

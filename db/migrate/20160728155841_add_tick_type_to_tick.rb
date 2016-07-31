class AddTickTypeToTick < ActiveRecord::Migration[5.0]
  def change
    add_reference :ticks, :tick_type
  end
end

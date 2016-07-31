class AddSettingsToTickTypes < ActiveRecord::Migration[5.0]
  def change
    add_reference :tick_types, :setting
  end
end

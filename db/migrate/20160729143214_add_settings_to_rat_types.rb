class AddSettingsToRatTypes < ActiveRecord::Migration[5.0]
  def change
    add_reference :rat_types, :setting
  end
end

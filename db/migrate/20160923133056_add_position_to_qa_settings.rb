class AddPositionToQaSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :qa_settings, :position, :integer
  end
end

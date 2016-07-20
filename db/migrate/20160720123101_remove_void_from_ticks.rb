class RemoveVoidFromTicks < ActiveRecord::Migration[5.0]
  def change
    remove_column "ticks", "void", :boolean
  end
end

class CleanupStaticTickNames < ActiveRecord::Migration[5.0]
  def change
    remove_column :ticks, "ab", :boolean
    remove_column :ticks, "late", :boolean
    remove_column :ticks, "dynamic", :boolean
    remove_column :ticks, "initiative", :boolean
  end
end

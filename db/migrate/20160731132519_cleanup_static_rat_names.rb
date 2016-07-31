class CleanupStaticRatNames < ActiveRecord::Migration[5.0]
  def change
    remove_column :rats, "longbreak", :boolean
    remove_column :rats, "latebreak", :boolean
    remove_column :rats, "offtask", :boolean
    rename_column :rats, :other, :notes
  end
end

class AddRatTypeToRat < ActiveRecord::Migration[5.0]
  def change
    add_reference :rats, :rat_type
  end
end

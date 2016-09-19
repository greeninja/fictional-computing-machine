class ChangeScoreToDecimal < ActiveRecord::Migration[5.0]
  def change
    change_column :tickets, :score, :decimal, :precision => 10, :scale => 3
  end
end

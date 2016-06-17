class AddTotalToBills < ActiveRecord::Migration
  def change
    add_column :bills, :total, :float
  end
end

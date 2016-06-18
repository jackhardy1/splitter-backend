class AddTotalToBills < ActiveRecord::Migration
  def change
    add_column :bills, :total, :integer
  end
end

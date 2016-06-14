class AddBillRefToItems < ActiveRecord::Migration
  def change
    add_reference :items, :bill, index: true, foreign_key: true
  end
end

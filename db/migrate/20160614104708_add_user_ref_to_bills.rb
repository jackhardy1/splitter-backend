class AddUserRefToBills < ActiveRecord::Migration
  def change
    add_reference :bills, :user, index: true, foreign_key: true
  end
end

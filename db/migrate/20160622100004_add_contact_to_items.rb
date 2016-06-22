class AddContactToItems < ActiveRecord::Migration
  def change
    add_column :items, :contact, :string
  end
end

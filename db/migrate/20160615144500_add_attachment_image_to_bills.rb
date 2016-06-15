class AddAttachmentImageToBills < ActiveRecord::Migration
  def self.up
    change_table :bills do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :bills, :image
  end
end

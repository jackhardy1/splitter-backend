class SplitterMailer < ApplicationMailer
  default from: "bills@splitter.com"

  def self.send_payment_email(bill_id)
    emails = self.find_emails(bill_id)
    self.find_items(emails)
  end

  def self.find_emails(id)
    Item.where(bill_id: id).select(:contact).map(&:contact).uniq
  end

  def self.find_items(emails)
    emails.each do |email|
      items = self.get_items(email)
      self.send_email(items).deliver_now
    end
  end

  def self.get_items(email)
    items = Item.where(contact: email)
  end

  def send_email(items)
    @items = Item.all
    email = @items.first.contact
    mail( to: email, subject: 'Here is your Bill')
  end

end

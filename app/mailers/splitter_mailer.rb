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
    @items = items
    find_user
    calculate_total
    find_recipient_email
    mail( to: @email, subject: 'Here is your Bill')
  end

  private

  def find_user
    find_bill
    @user = User.find(@bill.user_id)
  end

  def find_bill
    @bill = Bill.find(@items.first.bill_id)
  end

  def find_recipient_email
    @email = @items.first.contact
  end

  def calculate_total
    @total = 0
    @items.each do |item|
      @total += item.price
    end
  end

  end

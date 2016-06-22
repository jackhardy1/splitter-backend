describe SplitterMailer do

  subject(:mailer){ SplitterMailer }

  describe 'payment_email' do
    before(:each) do
      Bill.create(id: 3, event: 'fun')
      Item.create(bill_id: 3, contact: "test@gmail.com", name: "food", price: 3.00)
      Item.create(bill_id: 3, contact: "test2@gmail.com", name: "drink", price: 4.00)
    end

    it 'sends e-mail to given address' do
      expect{subject.send_payment_email(3)}.to change{ ActionMailer::Base.deliveries.size }.by 2
    end
  end

end

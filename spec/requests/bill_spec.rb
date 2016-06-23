describe 'bills API' do

  let(:json) { JSON.parse(response.body) }
  let(:image) { File.readlines("spec/fixtures/bill")[0] }

  describe '#index' do
    it 'sends a list of bills' do
      create_list :bill, 10
      get bills_path
      expect(response).to be_success
      expect(json.length).to eq 10
    end
  end

  describe '#create' do
    it 'creates a bill' do
      post bills_path, { event: 'party', image: image }
      expect(response).to be_success
      expect(Bill.count).to eq 1
    end

    it 'converts image to text, adding total to bill' do
      post bills_path, { event: "spanish", image: image }
      expect(response).to be_success
      expect(Bill.last.image_content_type).to eq 'image/gif'
      expect(Bill.last.total).to eq 33.00
    end

    it 'converts image to text, adding items to database' do
      post bills_path, { event: "spanish", image: image }
      expect(response).to be_success
      expect(Item.count).not_to eq 0
    end
  end

  describe '#show' do
    it 'sends an individual bill' do
      create_list :bill, 10
      my_bill = Bill.create(event: 'dinner')
      get bill_path(my_bill)
      expect(response).to be_success
      expect(json).to include_json(event: 'dinner')
      expect(json).not_to include_json(event: 'party')
    end
  end

  describe '#update' do
    it 'updates an individual bill' do
      my_bill = Bill.create(image: image)
      patch bill_path(my_bill), { event: 'Party at Noahs' }
      expect(response).to be_success
      expect(Bill.last.event).to eq('Party at Noahs')
    end
  end

  describe '#mailer' do
    it 'sends an e-mail to all item contacts in bill' do
      User.create(id: 2, provider: 'email', email: 'mybill@gmail.com', password: 'password')
      Bill.create(id: 3, event: 'fun', user_id: 2)
      Item.create(bill_id: 3, contact: 'test@gmail.com', name: 'food', price: 3.00)
      post mailer_bills_path, { bill_id: 3 }
      email = ActionMailer::Base.deliveries.last
      expect(email.to).to eq ['test@gmail.com']
      expect(email.body).to include 'You Have a Payment Request From Splitter'
    end
  end

end

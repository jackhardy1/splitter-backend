describe 'bills API' do

  let(:json) { JSON.parse(response.body) }

  describe '#index' do
    it 'sends a list of bills' do
      create_list :bill, 10
      get bills_path
      expect(response).to be_success
      expect(json.length).to eq 10
    end
  end

  describe '#create' do
    it 'creates a list of bills' do
      post bills_path, { params: { bill: { event: 'party' }}}
      expect(response).to be_success
      expect(Bill.count).to eq 1
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

end

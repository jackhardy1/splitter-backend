describe 'items API' do

  let(:json) { JSON.parse(response.body) }
  let(:bill_with_items) { create(:bill_with_items) }
  let(:bill) { create(:bill) }
  let(:item) { create(:item) }

  describe '#index' do
    it 'sends list of items for Bill' do
      get bill_items_path(bill_with_items)
      expect(response).to be_success
      expect(json.length).to eq 5
    end
  end

  describe '#create' do
    it 'creates an item' do
      post bill_items_path(bill), { params: { item: { name: 'chicken', price: '20' }}}
      expect(response).to be_success
      expect(Item.count).to eq 1
    end
  end


end

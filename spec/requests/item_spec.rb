describe 'items API' do

  let(:json) { JSON.parse(response.body) }

  describe '#index' do
    before do
      @bill = create(:bill_with_items)
    end

    it 'sends list of items for Bill' do
      get bill_items_path(@bill)
      expect(response).to be_success
      expect(json.length).to eq 5
    end
  end


end

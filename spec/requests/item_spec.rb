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

end

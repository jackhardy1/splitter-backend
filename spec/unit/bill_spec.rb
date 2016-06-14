describe Bill do
  
  it { is_expected.to have_many :items }

  it 'creates a new bill' do
    event_name = "stringfellows"
    Bill.create event: event_name
    my_bill = Bill.first
    expect(my_bill.event).to eq event_name
  end


end

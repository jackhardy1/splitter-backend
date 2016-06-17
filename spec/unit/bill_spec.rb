describe Bill do

  it { is_expected.to have_many :items }

  it 'creates a new bill' do
    event_name = "stringfellows"
    Bill.create event: event_name
    my_bill = Bill.first
    expect(my_bill.event).to eq event_name
  end

  # context 'adding image' do
  #
  #   before (:each) do
  #     Bill.create  event: "la tasc", image: File.readlines("spec/fixtures/bill")[0]
  #   end
  #
  #   it 'saves converted text total from image to database' do
  #     bill = Bill.last
  #     bill.tesseract
  #     expect(bill.last.total).to eq(33.35)
  #   end

  # end

end

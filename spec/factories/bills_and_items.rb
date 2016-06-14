FactoryGirl.define do
  factory :item do
    name "chicken"
    price 20.0
    bill
  end

  factory :bill do
    event "party"
    factory :bill_with_items do
      transient do
        items_count 5
      end

      after(:create) do |bill, evaluator|
        create_list(:item, evaluator.items_count, bill:bill)
      end
    end
  end


end

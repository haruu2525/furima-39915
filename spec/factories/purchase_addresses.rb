FactoryBot.define do
  factory :purchase_address do

    postal_code {"000-0000"}
    prefecture_id {1}
    city {"大阪市"}
    address {"0-0-0"}
    building {"センタービル"}
    phone_number {"00000000000"}
    token {"tok_kawaiisekai00000000000000000"}
    price {"5000"}
    
  end
end
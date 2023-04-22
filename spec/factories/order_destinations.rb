FactoryBot.define do
  factory :order_destinations do
    token { 'tok_abcdefghijk00000000000000000' }
    postcode { Faker::Number.decimal_part(digits: 3) + '-' + Faker::Number.decimal_part(digits: 4) }
    prefecture_id { Faker::Number.between(from: 1, to: 48) }
    city { Faker::Address.city }
    block { Faker::Address.street_address }
    building { Faker::Address.street_address }
    phone_number { Faker::Number.decimal_part(digits: 11) }
  end
end

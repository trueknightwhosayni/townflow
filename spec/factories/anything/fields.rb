FactoryBot.define do
  factory :anything_field, class: 'Anything::Field' do
    association :collection, factory: :anything_collection

    title { Faker::Lorem.word }
    name { Faker::Lorem.word }
    field_data_type { "text" }
  end
end

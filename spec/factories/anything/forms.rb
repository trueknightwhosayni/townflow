FactoryBot.define do
  factory :anything_form, class: 'Anything::Form' do
    association :collection, factory: :anything_collection

    title { Faker::Lorem.word }
    system { false }
  end
end

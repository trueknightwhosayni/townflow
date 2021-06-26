FactoryBot.define do
  factory :anything_view, class: 'Anything::View' do
    association :collection, factory: :anything_collection

    title { Faker::Lorem.word }
    view_type { [1, 2].sample }
  end
end

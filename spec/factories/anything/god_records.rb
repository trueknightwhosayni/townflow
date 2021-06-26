FactoryBot.define do
  factory :god_record, class: 'Anything::GodRecord' do
    association :collection, factory: :anything_collection

    anything_data { { name: 'Bruce' } }
  end
end

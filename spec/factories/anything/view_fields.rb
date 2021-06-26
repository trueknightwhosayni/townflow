FactoryBot.define do
  factory :anything_view_field, class: 'Anything::ViewField' do
    association :view, factory: :anything_view
    association :field, factory: :anything_field
  end
end

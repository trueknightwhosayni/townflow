FactoryBot.define do
  factory :erp_section, class: 'Erp::Section' do
    user
    association :section_category, factory: :erp_section_category

    sequence(:key) { |n| "section_category_#{n}" }
    title { Faker::Lorem.word }
    new_item_processor_class { 'SomeClass' }
    new_item_processor_attributes { 'SomeAttributes' }
  end
end
